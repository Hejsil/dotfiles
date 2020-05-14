#!/bin/sh -e

percent_to_color() {
    color_picked=$(($1 / 34))
    case $color_picked in
        0) xgetres bar.color2 ;;
        1) xgetres bar.color3 ;;
        *) xgetres bar.color1 ;;
    esac
}

colored_bars() {
    low=$(percent_to_color 0)
    mid=$(percent_to_color 50)
    high=$(percent_to_color 100)
    echo "%{F$low}▁,%{F$low}▂,%{F$mid}▃,%{F$mid}▄,%{F$mid}▅,%{F$high}▆,%{F$high}▇,%{F$high}█"
}

block() {
    printf '%s' '%{+o}'
    printf "$@"
    printf '%s' '%{-o}'
}

bar_block() {
    name=$1
    value=$2
    color=$3
    shift; shift; shift
    block ' %s: %s%s%s ' "$name" "%{F$color}" "$(echo "$value" | sab "$@")" "%{F-}"
}

volume_block() {
    bar_block "$1" "$2" "$(percent_to_color "$2")" -s '─,┫%{F-},━' -t mark-center
}

memory_block() {
    bar_block "$1" "$2" "-" -l1 -s "$(colored_bars)"
}

cpu_block() {
    name=$1
    values=$2
    bars=$(echo "$values" | tr ' ' '\n'  | sed '/^$/d' |
        sab -l1 -s "$(colored_bars)" |
        tr -d '\n')
    block ' %s: %s%s ' "$name" "$bars" "%{F-}"
}

mail=$(block ' mail:  0 ')
rss=$(block ' rss:  0 ')
date=$(block ' %s ' "$(date '+%b %d %a %R')")
mem=$(memory_block 'mem' 0)
cpu=$(cpu_block 'cpu' 0)
vol=$(volume_block 'vol' 0)
bspwm=''
win_block=''

while read -r line; do
    name=${line%%=*}
    value=${line#*=}

    # I wanted an efficient way of checking if the bar ever changed and only output it if it did. This
    # is what I came up with. I aligned the code the make it more readable. Basically, each case saves
    # the old value, costructs the new one, and checks if the value changed. If it didn't then we just
    # continue the loop.
    case $name in
        rss)   old=$rss;     rss=$(block ' %s:%3d '   "$name" "$value"); [  "$rss" = "$old" ] && continue ;;
        mail)  old=$mail;   mail=$(block ' %s:%3d '   "$name" "$value"); [ "$mail" = "$old" ] && continue ;;
        date)  old=$date;   date=$(block ' %s '               "$value"); [ "$date" = "$old" ] && continue ;;
        mem)   old=$mem;     mem=$(memory_block       "$name" "$value"); [  "$mem" = "$old" ] && continue ;;
        cpu)   old=$cpu;     cpu=$(cpu_block          "$name" "$value"); [  "$cpu" = "$old" ] && continue ;;
        vol)   old=$vol;     vol=$(volume_block       "$name" "$value"); [  "$vol" = "$old" ] && continue ;;
        win)   old=$win;     win=$value;                                 [  "$win" = "$old" ] && continue ;;
        bspwm) old=$bspwm; bspwm=$value;                                 [ "$bspm" = "$old" ] && continue ;;
        *)
            continue
            ;;
    esac
    
    bspc query -M --names | nl -w1 -v0 | while read -r index monitor; do
        printf '%s' "%{S${index}}%{c}${win}%{r}${mail} ${rss} ${mem} ${cpu} ${vol} ${date} "

        printf '%s' '%{l} '
        echo "$bspwm" | tr ':' '\n' |
            grep "$monitor" -A 1000 |
            sed -e '1d' -e '/[mMwW]/q' |
            sed '$d' |
        while read -r info; do
            num="${info#?}"
            case $info in
                o*) block ' %s*' "$num" ;;
                f*) block ' %s ' "$num" ;;
                O*) block '%s %s*%s' '%{+u}' "$num" '%{-u}' ;;
                F*) block '%s %s %s' "%{+u}" "$num" '%{-u}' ;;
                *) ;;
            esac
        done
        printf ' '
    done
    echo
done
