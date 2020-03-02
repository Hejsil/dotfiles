#!/bin/sh

. "$HOME/.local/script/colors.sh"

BAR_HEIGHT=30
bspc config top_padding "$BAR_HEIGHT"

bar-info.sh | bar-mk.sh | lemonbar  \
    -g "x$BAR_HEIGHT"               \
    -f 'JetBrains Mono-12'          \
    -f 'fontello-14'                \
    -B "#$COLOR0"                   \
    -F "#$COLOR5"                   \
    -u 2                            \
    -n 'lemonbar'                   \
    -o 1 &

trap "kill $!" INT TERM EXIT

while ! xdo id -a lemonbar; do
    sleep 0.1s
done

xdo below -t $(xdo id -n root) $(xdo id -a lemonbar)

wait
