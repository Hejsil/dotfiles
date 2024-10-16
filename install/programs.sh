#!/bin/sh -e

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

if ! grep '\[chaotic-aur\]' /etc/pacman.conf; then
    {
        echo '[chaotic-aur]'
        echo 'Include = /etc/pacman.d/chaotic-mirrorlist'
    } | sudo tee -a /etc/pacman.conf
fi

sudo pacman -Syu
sudo pacman -S yay
yay -S --noconfirm --asexplicit - <"$HOME/.config/essential-programs"
yay -S --noconfirm --asexplicit - <"$HOME/.config/installed-programs" || true

curl -L https://github.com/Hejsil/dipm/releases/latest/download/dipm-x86_64-linux-musl >/tmp/dipm &&
    chmod +x /tmp/dipm &&
    /tmp/dipm install dipm &&
    rm /tmp/dipm

grep -v '^dipm$' "$HOME/.config/dipm-installed-programs" |
    xargs -d'\n' dipm install
