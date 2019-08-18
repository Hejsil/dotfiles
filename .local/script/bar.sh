#!/bin/sh

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# Load theme from .Xresources
eval "$(grep 'color[0-9]*:[ ]*#' "$HOME/.Xresources" | sed -E 's/^\*color([0-9]*):[ ]*(.*)$/COLOR\1="\2"/')"

BAR_HEIGHT="35"
bspc config top_padding "$BAR_HEIGHT"

bar-info.sh | bar-mk.sh | lemonbar  \
    -g "x$BAR_HEIGHT"               \
    -f 'monospace:size=17'          \
    -B "$COLOR0"                    \
    -F "$COLOR15"                   \
    -u '2'                          \
    -o '1' &

wait
