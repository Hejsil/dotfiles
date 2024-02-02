#!/bin/sh -e

cd "$(dirname "$0")" || exit 1

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

install/linkup.sh
install/system-files.sh
install/programs.sh

local/script/generate

systemctl enable dbus-broker.service
