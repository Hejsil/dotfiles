#!/bin/sh

bar_height=26
width=667
x=$((2560-width))

chat_height=454
chat_y=$bar_height

cam_height=460
cam_y=$((1440 - cam_height))

chat_rect="rectangle=${width}x${chat_height}+${x}+${chat_y}"
cam_rect="rectangle=${width}x${cam_height}+${x}+${cam_y}"

bspc rule -a sticky-chat -o state=floating layer=above sticky=on "$chat_rect"
bspc rule -a sticky-background -o private=on sticky=on
bspc rule -a "mpv" -o state=floating layer=above sticky=on "$cam_rect"

kitty --class sticky-chat &
kitty --class sticky-background &
mpv av://v4l2:/dev/video0 --profile=low-latency --untimed --panscan=1.0  &


wait

