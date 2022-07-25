#!/bin/sh

bar_height=$(bspc config top_padding)
while [ "$bar_height" = 0 ]; do
    sleep 0.1s
    bar_height=$(bspc config top_padding)
done

lemonbar-maker --low "#$COLOR11" \
    --mid "#$COLOR10" \
    --high "#$COLOR8" |
    lemonbar \
        -g "x$bar_height" \
        -f "$(xgetres bar.font)" \
        -B "#$COLOR0" \
        -F "#$COLOR5" \
        -u 2 \
        -n 'lemonbar' &

while ! xdo id -a lemonbar 2>/dev/null >/dev/null; do
    sleep 0.1s
done

{
    xdo id -n root
    xdo id -a lemonbar
} | xargs -d'\n' xdo below -t

wait
