#!/bin/sh

set -e

eval "$(colors.sh)"

ICON_CALENDER="$(printf "\u$(printf "%x" 59399)")"
ICON_NEWSPAPER="$(printf "\u$(printf "%x" 61930)")"
ICON_DOWN="$(printf "\u$(printf "%x" 59398)")"
ICON_UP="$(printf "\u$(printf "%x" 59397)")"
ICON_DOWNLOAD="$(printf "\u$(printf "%x" 59400)")"
ICON_UPLOAD="$(printf "\u$(printf "%x" 59401)")"
ICON_VOLUME0="$(printf "\u$(printf "%x" 59393)")"
ICON_VOLUME1="$(printf "\u$(printf "%x" 59394)")"
ICON_VOLUME2="$(printf "\u$(printf "%x" 59395)")"
ICON_VOLUME3="$(printf "\u$(printf "%x" 59396)")"
ICON_TEMP0="$(printf "\u$(printf "%x" 62155)")"
ICON_TEMP1="$(printf "\u$(printf "%x" 62154)")"
ICON_TEMP2="$(printf "\u$(printf "%x" 62153)")"
ICON_TEMP3="$(printf "\u$(printf "%x" 62152)")"
ICON_TEMP4="$(printf "\u$(printf "%x" 62151)")"
ICON_SPEED="$(printf "\u$(printf "%x" 59392)")"
ICON_RSS="$(printf "\u$(printf "%x" 61763)")"
ICON_CHIP="$(printf "\u$(printf "%x" 62171)")"
ICON_CLOCK="$(printf "\u$(printf "%x" 59402)")"

block() {
    printf "%s" "%{U$COLOR6}%{+o}"
    printf "$@"
    printf "%s" "%{-o}"
}

while read -r LINE; do
    eval "$LINE"

    for MONITOR in $(bspc query -M --names | nl -w1 -v0 | cut -f1); do
        printf "%s" "%{S$MONITOR}%{l}"

        printf "%s" "%{c}"

        printf "%s" "%{r}"
        block " %3d%% %s " "$CPU" "$ICON_SPEED"
        printf " "
        block " %3d%% %s " "$MEM" "$ICON_CHIP"
        printf " "
        block " %3d %s " "$NEWS" "$ICON_RSS"
        printf " "
        block " %3d%% %s " "$VOLUME" "$(echo "$VOLUME" | sab -l 1 -s "$ICON_VOLUME1$ICON_VOLUME2$ICON_VOLUME3")"
        printf " "
        block " %s %s " "$TIME" "$ICON_CLOCK"
        printf " "
    done
    echo ""
done
