#!/bin/sh -e

cd "$(dirname "$0")/.."

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
(
    cd paru
    makepkg -si
)

paru -S paru
rm -r paru

sudo cp -ri "systemd/getty@tty1.service.d" "/etc/systemd/system/"
