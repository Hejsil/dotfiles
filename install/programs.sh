#!/bin/sh -e

if ! grep '^Color' /etc/pacman.conf >/dev/null; then
    sudo sed -i 's/^#Color$/Color/' /etc/pacman.conf
fi

if ! grep '\[chaotic-aur\]' /etc/pacman.conf >/dev/null; then
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    {
        echo '[chaotic-aur]'
        echo 'Include = /etc/pacman.d/chaotic-mirrorlist'
    } | sudo tee -a /etc/pacman.conf

    sudo pacman -Syu
fi

if ! command -v yay >/dev/null; then
    sudo pacman -S --noconfirm yay
fi

if ! command -v dipm >/dev/null; then
    curl -L https://github.com/Hejsil/dipm/releases/latest/download/dipm-x86_64-linux-musl >/tmp/dipm &&
        chmod +x /tmp/dipm &&
        /tmp/dipm install dipm &&
        rm /tmp/dipm
fi
