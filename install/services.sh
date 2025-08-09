#!/bin/sh -e

~/.local/script/ask systemctl enable --user activate-linux
~/.local/script/ask systemctl enable --user anki
~/.local/script/ask systemctl enable --user dipm-pkgs-update
~/.local/script/ask systemctl enable --user discord
~/.local/script/ask systemctl enable --user mail
~/.local/script/ask systemctl enable --user replay
~/.local/script/ask systemctl enable --user steam
~/.local/script/ask systemctl enable --user wallpaper

~/.local/script/ask systemctl enable --user optimize.timer
~/.local/script/ask systemctl enable --user sync-aniz.timer
~/.local/script/ask systemctl enable --user rss-sync.timer

~/.local/script/ask systemctl enable ollama
~/.local/script/ask systemctl enable rustdesk

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
