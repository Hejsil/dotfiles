#!/bin/sh

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

while read -r LINE; do
    eval "$LINE"

    for MONITOR in $(bspc query -M --names | nl -w1 -v0 | cut -f1); do
        printf "%s" "%{S$MONITOR}%{l}"

        printf "%s" "%{c}"
        printf "%s" "%{U$COLOR7}%{+o} $ICON_CALENDER $DATE %{-o}"

        printf "%s" "%{r}"
        printf "%s" "%{U$COLOR8}%{+o} $(printf "%7s" "$(bytes.sh "$NET_UP")") $ICON_UPLOAD %{-o} "
        printf "%s" "%{U$COLOR9}%{+o} $(printf "%7s" "$(bytes.sh "$NET_DOWN")") $ICON_DOWNLOAD %{-o} "
        printf "%s" "%{U$COLOR10}%{+o} $(printf "%3d" "$CPU")% $ICON_SPEED %{-o} "
        printf "%s" "%{U$COLOR11}%{+o} $(printf "%3d" "$MEM")% $ICON_CHIP %{-o} "
        printf "%s" "%{U$COLOR12}%{+o} $(printf "%2d" "$NEWS") $ICON_RSS %{-o} "
        printf "%s" "%{U$COLOR13}%{+o} $(printf "%4s" "$VOLUME%") $(echo "$VOLUME" | sab -l 1 -s "$ICON_VOLUME1$ICON_VOLUME2$ICON_VOLUME3") %{-o} "
    done
    echo ""
done
