#!/bin/sh -e

~/.local/script/ask systemctl enable --user dipm-pkgs-update.service
~/.local/script/ask systemctl enable --user discord.service
~/.local/script/ask systemctl enable --user easyeffects.service
~/.local/script/ask systemctl enable --user replay.service
~/.local/script/ask systemctl enable --user steam.service
~/.local/script/ask systemctl enable --user thunderbird.service
~/.local/script/ask systemctl enable --user wallpaper.service

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
