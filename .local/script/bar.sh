#!/bin/sh

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

eval "$(colors.sh)"

BAR_HEIGHT="35"
bspc config top_padding "$BAR_HEIGHT"

bar-info.sh | bar-mk.sh | lemonbar  \
    -g "x$BAR_HEIGHT"               \
    -f 'monospace-15'               \
    -f 'fontello-17'                \
    -B "$COLOR0"                    \
    -F "$COLOR5"                    \
    -u '2'                          \
    -o '1' &

wait
