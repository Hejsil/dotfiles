#!/bin/sh

set -e

. "$HOME/.local/script/colors.sh"

# dash shell has a builtin printf which does
# not support \uXXXX.
printff() {
    "$(which printf)" "$*"
}

icon_calender=$(printff "\u$(printf "%x" 59399)")
icon_newspaper=$(printff "\u$(printf "%x" 61930)")
icon_down=$(printff "\u$(printf "%x" 59398)")
icon_up=$(printff "\u$(printf "%x" 59397)")
icon_download=$(printff "\u$(printf "%x" 59400)")
icon_upload=$(printff "\u$(printf "%x" 59401)")
icon_volume0=$(printff "\u$(printf "%x" 59393)")
icon_volume1=$(printff "\u$(printf "%x" 59394)")
icon_volume2=$(printff "\u$(printf "%x" 59395)")
icon_volume3=$(printff "\u$(printf "%x" 59396)")
icon_temp0=$(printff "\u$(printf "%x" 62155)")
icon_temp1=$(printff "\u$(printf "%x" 62154)")
icon_temp2=$(printff "\u$(printf "%x" 62153)")
icon_temp3=$(printff "\u$(printf "%x" 62152)")
icon_temp4=$(printff "\u$(printf "%x" 62151)")
icon_speed=$(printff "\u$(printf "%x" 59392)")
icon_rss=$(printff "\u$(printf "%x" 61763)")
icon_chip=$(printff "\u$(printf "%x" 62171)")
icon_clock=$(printff "\u$(printf "%x" 59402)")

block() {
    printf '%s' "%{U#$COLOR6}%{+o}"
    printf "$@"
    printf '%s' '%{-o}'
}

while read -r LINE; do
    eval "$LINE"

    bspc query -M --names | nl -w1 -v0 | while read -r INDEX MONITOR; do
        printf '%s' "%{S$INDEX}"

        printf '%s' '%{c}'
        printf '%s' "$WINDOW"

        printf '%s' '%{l} '
        echo "$BSPWM_REPORT" | tr ':' '\n' |
            grep "$MONITOR" -A 1000 |
            sed -e '1d' -e '/[mMwW]/q' |
            sed '$d' |
        while read -r INFO; do
            NUM="${INFO#?}"
            case $INFO in
                o*) block ' %s*' "$NUM" ;;
                f*) block ' %s ' "$NUM" ;;
                O*) block '%s %s*%s' '%{+u}' "$NUM" '%{-u}' ;;
                F*) block '%s %s %s' "%{+u}" "$NUM" '%{-u}' ;;
                *) ;;
            esac
        done
        printf " "

        printf '%s' '%{r} '
        block ' %3d%% %s ' "$CPU" "$icon_speed"
        printf ' '
        block ' %3d%% %s ' "$MEM" "$icon_chip"
        printf ' '
        block ' %3s %s ' "$MAILS" "$icon_newspaper"
        printf ' '
        block ' %3d %s ' "$NEWS" "$icon_rss"
        printf ' '
        block ' %3d%% %s ' "$VOLUME" "$(echo "$VOLUME" | sab -l 1 -s "$icon_volume1$icon_volume2$icon_volume3")"
        printf ' '
        block ' %s %s ' "$TIME" "$icon_clock"
        printf ' '
    done
    echo
done
