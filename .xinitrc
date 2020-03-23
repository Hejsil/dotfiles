#!/usr/bin/env sh

USER_RESOURCES="$HOME/.Xresources"
SYS_RESOURCES=/etc/X11/xinit/.Xresources
[ -f "$SYS_RESOURCES" ] && xrdb -merge "$SYS_RESOURCES"
[ -f "$USER_RESOURCES" ] && xrdb -merge "$USER_RESOURCES"

xrandr --output HDMI-0 --mode 1920x1080 --right-of DP-0 \
    --output DP-0 --primary --mode 2560x1440 --rate 144
wall.sh "$HOME/MEGA/Pictures/Wallpapers" &
megasync &
minidlnad -S -f "/home/$USER/.config/minidlna/minidlna.conf" -P "/home/$USER/.config/minidlna/minidlna.pid" &
transmission-daemon -f &
redshift &
go-to-sleep.sh &

exec bspwm
