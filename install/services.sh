#!/bin/sh -e

~/.local/script/ask systemctl enable --user dipm-pkgs-update
~/.local/script/ask systemctl enable --user replay
~/.local/script/ask systemctl enable --user wallpaper

~/.local/script/ask systemctl enable --user rss-sync.timer

# Required services
systemctl enable foot-server --user
systemctl enable poweralertd --user
systemctl enable syncthing --user
systemctl enable udiskie --user
systemctl enable waybar --user
systemctl enable wob.socket --user
systemctl enable wob --user
systemctl enable ydotool --user

systemctl enable haveged
systemctl enable sshd
systemctl enable systemd-oomd
systemctl enable systemd-resolved
systemctl enable timeshift-boot.timer
systemctl enable udisks2

systemctl enable reflector.timer
