#!/usr/bin/env sh

USER_RESOURCES="$HOME/.Xresources"
SYS_RESOURCES=/etc/X11/xinit/.Xresources
[ -f "$SYS_RESOURCES" ] && xrdb -merge "$SYS_RESOURCES"
[ -f "$USER_RESOURCES" ] && xrdb -merge "$USER_RESOURCES"

exec bspwm
