#!/bin/sh -e

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git

cd paru
makepkg -si

paru -S paru
cd ..

rm -r paru
