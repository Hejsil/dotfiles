#!/bin/sh

proc=$$
channel=$1
chat_dir=$2
chat_file="$chat_dir/$channel"

in=$(cat)

mon_names=$(echo "$in" | rg '\.pokemons\[\d*\].name=.*')
type_names=$(echo "$in" | rg '\.types\[\d*\].name=.*')
ability_names=$(echo "$in" | rg '\.abilities\[\d*\].name=.*')
trainer_names=$(echo "$in" | rg '\.trainers\[\d*\].name=.*')
trainer_parties=$(echo "$in" | rg '\.trainers\[\d*\].party\[\d*\]')

find_in() {
    str=$1
    regex=$2
    shift; shift
    echo "$str" 2>/dev/null | tr -d ' ' 2>/dev/null | rg -i "^$regex$" -r '$1'
}

find_mon_id() {
    [ -z "$1" ] && return
    find_in "$mon_names" "\.pokemons\[(\d*)\]\.name=$1"
}

find_mon_name() {
    [ -z "$1" ] && return
    find_in "$mon_names" "\.pokemons\[$1\]\.name=(.*)"
}

find_type_id() {
    [ -z "$1" ] && return
    find_in "$type_names" "\.types\[(\d*)\]\.name=$1"
}

find_type_name() {
    [ -z "$1" ] && return
    find_in "$type_names" "\.types\[$1\]\.name=(.*)"
}

find_ability_id() {
    [ -z "$1" ] && return
    find_in "$ability_names" "\.abilities\[(\d*)\]\.name=$1"
}

find_ability_name() {
    [ -z "$1" ] && return
    find_in "\.abilities\[$1\]\.name=(.*)"
}

find_trainer_ids() {
    [ -z "$1" ] && return
    find_in "$trainer_names" "\.trainers\[(\d*)\]\.name=$1"
}

find_trainer_name() {
    [ -z "$1" ] && return
    find_in "$trainer_names" "\.trainers\[$1\]\.name=(.*)"
}

evo_lvl_cmd() {
    target=$(find_mon_id "$1")
    dest=$(find_mon_id "$2")
    lvl=$3

    [ -z "$target" ] && return
    [ -z "$dest" ] && return
    [ -z "$lvl" ] && return

    printf "%s evolves to %s at level %d\n" \
        "$(find_mon_name "$target")" \
        "$(find_mon_name "$dest")" \
        "$lvl" >&2
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

    printf "%s typing is %s %s\n" \
        "$(find_mon_name "$target")" \
        "$(find_type_name "$t1")" \
        "$(find_type_name "$t2")" >&2
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

    printf "%s %s is %d\n" \
        "$(find_mon_name "$target")" \
        "$stat" \
        "$num" >&2
    printf ".pokemons[%d].stats.%s=%d\n" "$target" "$stat" "$num"
}

ability_cmd() {
    target=$(find_mon_id "$1")
    a1=$(find_ability_id "$2")
    a2=$(find_ability_id "$3")
    a3=$(find_ability_id "$4")

    [ -z "$target" ] && return
    [ -z "$a1" ] && return
    [ -z "$a2" ] && a2='0'
    [ -z "$a3" ] && a3='0'

    printf "%s abilities are %s %s %s\n" \
        "$(find_mon_name "$target")" \
        "$(find_ability_name "$a1")" \
        "$(find_ability_name "$a2")" \
        "$(find_ability_name "$a3")" >&2
    printf ".pokemons[%d].abilities[0]=%d\n" "$target" "$a1"
    printf ".pokemons[%d].abilities[1]=%d\n" "$target" "$a2"
    printf ".pokemons[%d].abilities[2]=%d\n" "$target" "$a3"
}

static_mon_cmd() {
    target=$(find_mon_id "$1")
    dest=$(find_mon_id "$2")

    [ -z "$target" ] && return
    [ -z "$dest" ] && return

    printf "static pokemon %s replaced with %s\n" \
        "$(find_mon_name "$target")" \
        "$(find_mon_name "$dest")" >&2
    echo "$in" | rg "(\.static_pokemons\[\d*\]\.species=)$target" -r "\${1}$dest"
}

trainer_party_cmd() {
    trainer=$(find_trainer_ids "$1" | sed "${2}q;d")
    p1=$(find_mon_id "$3")
    p2=$(find_mon_id "$4")
    p3=$(find_mon_id "$5")
    p4=$(find_mon_id "$6")
    p5=$(find_mon_id "$7")
    p6=$(find_mon_id "$8")
    party=$(printf "%s\n%s\n%s\n%s\n%s\n%s\n" "$p1" "$p2" "$p3" "$p4" "$p5" "$p6" | sed -r '/^$/d')
    party_size=$(echo "$party" | wc -l)

    [ -z "$trainer" ] && return
    [ -z "$party" ] && return
    [ "$party_size" = '0' ] && return

    printf "%s %s has " \
        "$(find_trainer_name "$trainer")" \
        "$2" >&2

    printf ".trainers[%d].party_type=none\n" "$trainer"
    printf ".trainers[%d].party_size=%s\n" "$trainer" "$party_size"

    echo "$party" | awk '{print NR-1 " " $0}' | while read i member; do
        level=$(find_in "$trainer_parties" "\.trainers\[$trainer\]\.party\[$i\].level=(.*)")
        [ -z "$level" ] && level=$last_level

        printf "lvl %s %s, " \
            "$level" \
            "$(find_mon_name "$member")" >&2

        printf ".trainers[%s].party[%s].level=%s\n" "$trainer" "$i" "$level"
        printf ".trainers[%s].party[%s].species=%s\n" "$trainer" "$i" "$member"
        last_level=$level
    done

    printf "\n" >&2
}

mkdir -p "$chat_dir"
touch "$chat_file"
tail -n 0 -f "$chat_file" | rg --line-buffered -o '<([\w\d_-]*)>\s*!mod (.*)' -r '$1 $2' |
while read user a1 a2 a3 a4 a5 a6 a7 a8 a9; do
    if echo "$a2" | rg -i '\->' >/dev/null; then
        evo_cmd "$a1" "$a3" "$a4" "$a5"
    elif echo "$a2 $a3" | rg -i 'evolves? to' >/dev/null; then
        evo_cmd "$a1" "$a4" "$a5" "$a6"
    elif echo "$a2" | rg -i 'evolves?' >/dev/null; then
        evo_cmd "$a1" "$a3" "$a4" "$a5"

    elif echo "$a2 $a3" | rg -i 'typ(es?|ing) is' >/dev/null; then
        type_cmd "$a1" "$a4" "$a5"
    elif echo "$a2" | rg -i 'typ(es?|ing)|is' >/dev/null; then
        type_cmd "$a1" "$a3" "$a4"

    elif echo "$a2 $a3 $a4" | rg -i 'has \d* (hp|(sp_)?(attack|defense)|speed)' >/dev/null; then
        stat_cmd "$a1" "$a4" "$a3"
    elif echo "$a2 $a3" | rg -i '(hp|(sp_)?(attack|defense)|speed) is' >/dev/null; then
        stat_cmd "$a1" "$a2" "$a4"

    elif echo "$a2 $a3" | rg -i 'abilit(ies|y) (are|is)' >/dev/null; then
        ability_cmd "$a1" "$a4" "$a5" "$a6"
    elif echo "$a2" | rg -i 'abilit(ies|y)' >/dev/null; then
        ability_cmd "$a1" "$a3" "$a4" "$a5"

    elif echo "$a1 $a2 $a3 $a5" | rg -i 'replace static pokemons? with' >/dev/null; then
        static_mon_cmd "$a4" "$a6"
    elif echo "$a1 $a2 $a4" | rg -i 'replace static with' >/dev/null; then
        static_mon_cmd "$a3" "$a5"
    elif echo "$a1 $a2" | rg -i 'replace static' >/dev/null; then
        static_mon_cmd "$a3" "$a4"

    elif echo "$a2 $a3" | rg -i '\d* has' >/dev/null; then
        trainer_party_cmd "$a1" "$a2" "$a4" "$a5" "$a6" "$a7" "$a8" "$a9"
    elif echo "$a2" | rg -i 'has' >/dev/null; then
        trainer_party_cmd "$a1" "1" "$a3" "$a4" "$a5" "$a6" "$a7" "$a8"

    elif echo "$a1" | rg "done" >/dev/null; then
        kill "$proc"
        exit 0
    fi
done

