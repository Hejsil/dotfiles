#!/bin/sh

bar_height=$(bspc config top_padding)
while [ "$bar_height" = 0 ]; do
    sleep 0.1s
    bar_height=$(bspc config top_padding)
done

lemonbar-maker --low "$(xgetres bar.color2)" \
    --mid "$(xgetres bar.color3)" \
    --high "$(xgetres bar.color1)" |
    lemonbar \
        -g "x$bar_height" \
        -f "$(xgetres bar.font)" \
        -B "$(xgetres bar.color0)" \
        -F "$(xgetres bar.color7)" \
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
