#!/bin/sh -e

~/.local/script/ask systemctl enable activate-linux --user
~/.local/script/ask systemctl enable caprine --user
~/.local/script/ask systemctl enable discord --user
~/.local/script/ask systemctl enable mail --user
~/.local/script/ask systemctl enable replay --user
~/.local/script/ask systemctl enable steam --user
~/.local/script/ask systemctl enable wallpaper --user

~/.local/script/ask systemctl enable optimize.timer --user
~/.local/script/ask systemctl enable sync-aniz.timer --user
~/.local/script/ask systemctl enable rss-sync.timer --user

# Required services
systemctl enable foot-server --user
systemctl enable poweralertd --user
systemctl enable syncthing --user
systemctl enable udiskie --user
systemctl enable waybar --user
systemctl enable wob.socket --user
systemctl enable wob --user

systemctl enable haveged
systemctl enable reflector
systemctl enable sshd
systemctl enable udisks2
