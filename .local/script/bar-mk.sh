#!/bin/sh

# Load theme from .Xresources
eval "$(grep 'color[0-9]*:[ ]*#' "$HOME/.Xresources" | sed -E 's/^\*color([0-9]*):[ ]*(.*)$/COLOR\1="\2"/')"

while read -r LINE; do
    eval "$LINE"

    for MONITOR in $(bspc query -M --names | nl -w1 -v0 | cut -f1); do
        printf "%s" "%{S$MONITOR}%{l}"
        printf "%s" " %{U$COLOR1}%{$COLOR1}%{+o} $(printf "up %7s" "$(bytes.sh "$NET_UP")") %{-o}"
        printf "%s" " %{U$COLOR2}%{+o} $(printf "down %7s" "$(bytes.sh "$NET_DOWN")") %{-o}"
        printf "%s" " %{U$COLOR3}%{+o} $(printf "cpu %3d" "$CPU")% %{-o}"
        printf "%s" " %{U$COLOR4}%{+o} $(printf "mem %3d" "$MEM")% %{-o}"

        printf "%s" "%{c}"
        printf "%s" "%{U$COLOR15}%{+o} $DATE %{-o}"

        printf "%s" "%{r}"
        printf "%s" "%{U$COLOR5}%{+o} $(printf "news %2d" "$NEWS") %{-o} "
        printf "%s" "%{U$COLOR6}%{+o} $(echo "$VOLUME" | sab -l 10 -s ' ▏▎▍▌▋▊▉█') $(printf "%4s" "$VOLUME%") %{-o} "
    done
    echo ""
done
