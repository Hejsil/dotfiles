#!/bin/sh

set -e

SCHEME=$HOME/.local/script/colors.sh
eval "$(cat "$SCHEME")"

# dash shell has a builtin printf which does
# not support \uXXXX.
printff() {
    "$(which printf)" "$*"
}

ICON_CALENDER=$(printff "\u$(printf "%x" 59399)")
ICON_NEWSPAPER=$(printff "\u$(printf "%x" 61930)")
ICON_DOWN=$(printff "\u$(printf "%x" 59398)")
ICON_UP=$(printff "\u$(printf "%x" 59397)")
ICON_DOWNLOAD=$(printff "\u$(printf "%x" 59400)")
ICON_UPLOAD=$(printff "\u$(printf "%x" 59401)")
ICON_VOLUME0=$(printff "\u$(printf "%x" 59393)")
ICON_VOLUME1=$(printff "\u$(printf "%x" 59394)")
ICON_VOLUME2=$(printff "\u$(printf "%x" 59395)")
ICON_VOLUME3=$(printff "\u$(printf "%x" 59396)")
ICON_TEMP0=$(printff "\u$(printf "%x" 62155)")
ICON_TEMP1=$(printff "\u$(printf "%x" 62154)")
ICON_TEMP2=$(printff "\u$(printf "%x" 62153)")
ICON_TEMP3=$(printff "\u$(printf "%x" 62152)")
ICON_TEMP4=$(printff "\u$(printf "%x" 62151)")
ICON_SPEED=$(printff "\u$(printf "%x" 59392)")
ICON_RSS=$(printff "\u$(printf "%x" 61763)")
ICON_CHIP=$(printff "\u$(printf "%x" 62171)")
ICON_CLOCK=$(printff "\u$(printf "%x" 59402)")

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
        block ' %3d%% %s ' "$CPU" "$ICON_SPEED"
        printf ' '
        block ' %3d%% %s ' "$MEM" "$ICON_CHIP"
        printf ' '
        block ' %3d %s ' "$NEWS" "$ICON_RSS"
        printf ' '
        block ' %3d%% %s ' "$VOLUME" "$(echo "$VOLUME" | sab -l 1 -s "$ICON_VOLUME1$ICON_VOLUME2$ICON_VOLUME3")"
        printf ' '
        block ' %s %s ' "$TIME" "$ICON_CLOCK"
        printf ' '
    done
    echo
done
