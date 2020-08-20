#!/bin/sh

proc=$$
channel=$1
chat_dir=$2
chat_file="$chat_dir/$channel"

in=$(cat)

find_id() {
    echo "$in" | rg -i "$1" -r '$1' | head -n 1
}

find_mon_id() {
    [ -z "$1" ] && return
    find_id "\.pokemons\[(\d*)\]\.name=$1"
}

find_type_id() {
    [ -z "$1" ] && return
    find_id "\.types\[(\d*)\]\.name=$1"
}

evo_lvl_cmd() {
    target=$(find_mon_id "$1")
    dest=$(find_mon_id "$2")
    lvl=$3

    [ -z "$target" ] && return
    [ -z "$dest" ] && return
    [ -z "$lvl" ] && return

    printf ".pokemons[%d].evos[0].target=%d\n" "$target" "$dest"
    printf ".pokemons[%d].evos[0].param=%d\n" "$target" "$lvl"
    printf ".pokemons[%d].evos[0].method=level_up\n" "$target"
}

evo_cmd() {
    method=$3
    echo "$method" | rg -i 'level|lvl' >/dev/null && evo_lvl_cmd "$1" "$2" "$4"
}

type_cmd() {
    target=$(find_mon_id "$1")
    t1=$(find_type_id "$2")
    t2=$(find_type_id "$3")

    [ -z "$target" ] && return
    [ -z "$t1" ] && return
    [ -z "$t2" ] && t2=$t1

    printf ".pokemons[%d].types[0]=%d\n" "$target" "$t1"
    printf ".pokemons[%d].types[1]=%d\n" "$target" "$t2"
}

stat_cmd() {
    target=$(find_mon_id "$1")
    stat=$2
    num=$3

    [ -z "$target" ] && return
    [ -z "$stat" ] && return
    [ -z "$num" ] && return

    printf ".pokemons[%d].stats.%s=%d\n" "$target" "$stat" "$num"
}

mkdir -p "$chat_dir"
touch "$chat_file"
tail -n 0 -f "$chat_file" | rg --line-buffered -o '<([\w\d_-]*)>(.*)' -r '$1$2' |
while read user a1 a2 a3 a4 a5 a6 a7; do
    echo "$a2" | rg -i '\->' >/dev/null && evo_cmd "$a1" "$a3" "$a4" "$a5"
    echo "$a2" | rg -i 'evolves?' >/dev/null && evo_cmd "$a1" "$a3" "$a4" "$a5"
    echo "$a2$a3" | rg -i 'evolves?to' >/dev/null && evo_cmd "$a1" "$a4" "$a5" "$a6"

    echo "$a2" | rg -i 'typ(es?|ing)|is' >/dev/null && type_cmd "$a1" "$a3" "$a4"
    echo "$a2$a3" | rg -i 'typ(es?|ing)is' >/dev/null && type_cmd "$a1" "$a4" "$a5"

    echo "$a2$a3" | rg -i '(hp|(sp_)?(attack|defense)|speed)is' >/dev/null && stat_cmd "$a1" "$a2" "$a4"

    echo "$user $a2" | rg "$user done" >/dev/null && kill "$proc" && exit 0
done

