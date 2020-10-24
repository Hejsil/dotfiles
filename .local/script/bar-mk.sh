#!/bin/sh -e

color1=$(xgetres bar.color1)
color2=$(xgetres bar.color2)
color3=$(xgetres bar.color3)
low=$color2
mid=$color3
high=$color1
colored_bars="%{F$low}▁,%{F$low}▂,%{F$mid}▃,%{F$mid}▄,%{F$mid}▅,%{F$high}▆,%{F$high}▇,%{F$high}█"

percent_to_color() {
    color_picked=$(($1 / 34))
    case $color_picked in
        0) echo "$color2" ;;
        1) echo "$color3" ;;
        *) echo "$color1" ;;
    esac
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
    command=$4
    shift; shift; shift; shift
    block '%s %s: %s%s%s %s' "%{A1:$command &:}" "$name" "%{F$color}" \
        "$(echo "$value" | sab "$@")" "%{F-}" "%{A}"
}

volume_block() {
    bar_block "$1" "$2" "$(percent_to_color "$2")" "pavucontrol" -s '─,┫%{F-},━' -t mark-center
}

memory_block() {
    bar_block "$1" "$2" "-" "true" -l1 -s "$colored_bars"
}

cpu_block() {
    name=$1
    values=$2
    bars=$(echo "$values" | tr ' ' '\n'  | sed '/^$/d' |
        sab -l1 -s "$colored_bars" |
        tr -d '\n')
    block '%s %s: %s%s %s' "%{A1:$TERMINAL -e gotop &:}" "$name" "$bars" "%{F-}" '%{A}'
}

mail_block() {
    name=$1
    value=$2
    block '%s %s:%3d %s' "%{A1:$TERMINAL -e aerc &:}" "$name" "$value" '%{A}'
}

rss_block() {
    name=$1
    value=$2
    block '%s %s:%3d %s' "%{A1:$TERMINAL -c 'pick-dialog' -e rss-read.sh &:}" "$name" "$value" '%{A}'
}

date=$(block ' %s ' "$(date '+%b %d %a %R')")
rss=$(rss_block 'rss' 0)
mail=$(mail_block 'mail' 0)
mem=$(memory_block 'mem' 0)
cpu=$(cpu_block 'cpu' 0)
vol=$(volume_block 'vol' 0)
bspwm=''
win_block=''

while read -r line; do
    name=${line%%=*}
    value=${line#*=}

    case $name in
        date)   date=$(block ' %s '         "$value") ;;
        rss)     rss=$(rss_block    "$name" "$value") ;;
        mail)   mail=$(mail_block   "$name" "$value") ;;
        mem)     mem=$(memory_block "$name" "$value") ;;
        cpu)     cpu=$(cpu_block    "$name" "$value") ;;
        vol)     vol=$(volume_block "$name" "$value") ;;
        win)     win=$value                           ;;
        bspwm) bspwm=$value                           ;;
        *)     continue                               ;;
    esac

    bspc query -M --names | nl -w1 -v0 | while read -r index monitor; do
        printf '%s' "%{S${index}}"

        printf '%s' '%{l} '
        echo "$bspwm" | tr ':' '\n' |
            grep "$monitor" -A 1000 |
            sed -e '1d' -e '/[mMwW]/q' |
            sed '$d' |
        while read -r info; do
            num="${info#?}"
            case $info in
                o*|u*) block ' %s*' "$num" ;;
                f*) block ' %s ' "$num" ;;
                O*|U*) block '%s %s*%s' '%{+u}' "$num" '%{-u}' ;;
                F*) block '%s %s %s' "%{+u}" "$num" '%{-u}' ;;
                *) ;;
            esac
        done
        printf '  %s%s ' "${win}" "%{r} ${mail} ${rss} ${mem} ${cpu} ${vol} ${date}"
    done
    echo
done
