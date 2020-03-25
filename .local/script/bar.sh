#!/bin/sh

. "$HOME/.local/script/colors.sh"

bar_height=30
bspc config top_padding "$bar_height"

bar-info.sh | bar-mk.sh | lemonbar  \
    -g "x$bar_height"               \
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
