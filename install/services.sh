#!/bin/sh -e

~/.local/script/ask systemctl enable activate-linux --user
~/.local/script/ask systemctl enable caprine --user
~/.local/script/ask systemctl enable discord --user
~/.local/script/ask systemctl enable mail --user
~/.local/script/ask systemctl enable poweralert --user
~/.local/script/ask systemctl enable replay --user
~/.local/script/ask systemctl enable steam --user
~/.local/script/ask systemctl enable volume-bar --user
~/.local/script/ask systemctl enable wallpaper --user

~/.local/script/ask systemctl enable optimize.timer --user
~/.local/script/ask systemctl enable sync-aniz.timer --user
~/.local/script/ask systemctl enable rss-sync.timer --user

# Required services
systemctl enable bar --user
systemctl enable foot --user
systemctl enable hyprland --user
systemctl enable syncthing --user
systemctl enable udiskie --user

systemctl enable haveged
systemctl enable reflector
systemctl enable sshd
systemctl enable udisks2
