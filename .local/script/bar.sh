#!/bin/sh

bar_height=26
bspc config top_padding "$bar_height"

bar-info.sh | bar-mk.sh | lemonbar  \
    -g "x$bar_height"               \
    -f "$(xgetres bar.font)"        \
    -f "$(xgetres bar.symbol_font)" \
    -B "$(xgetres bar.color0)"      \
    -F "$(xgetres bar.color7)"      \
    -u 2                            \
    -n 'lemonbar'              &

trap "kill $!" INT TERM EXIT

while ! xdo id -a lemonbar; do
    sleep 0.1s
done

xdo below -t $(xdo id -n root) $(xdo id -a lemonbar)

wait
