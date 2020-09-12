#!/usr/bin/env sh

user_resources="$HOME/.config/xorg/resources"
sys_resources=/etc/X11/xinit/.Xresources
[ -f "$sys_resources" ] && xrdb -merge "$sys_resources"
[ -f "$user_resources" ] && xrdb -merge "$user_resources"

xset r rate 300 50
xset s off
xset s off -dpms
setxkbmap -layout "dk"
xrandr --output HDMI-0 --mode 1920x1080 --right-of DP-0 \
    --output DP-0 --primary --mode 2560x1440 --rate 144

wall.sh "$HOME/mega/images/wallpapers" >/tmp/wall.sh.log 2>/tmp/wall.sh.log &
megasync &
transmission-daemon -f &
redshift &
xbanish &
mbsync -a -c "$HOME/.config/isync/mbsyncrc" &

exec bspwm
