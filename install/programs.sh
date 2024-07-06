#!/bin/sh -e

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo pacman -Syu
sudo pacman -S paru --confirm --needed
paru -S --noconfirm --asexplicit - <"$HOME/.config/essential-programs"
paru -S --noconfirm --asexplicit - <"$HOME/.config/installed-programs" || true

curl -L https://github.com/Hejsil/dipm/releases/latest/download/dipm-x86_64-linux-musl >/tmp/dipm &&
    chmod +x /tmp/dipm &&
    /tmp/dipm install dipm &&
    rm /tmp/dipm

grep -v '^dipm$' .config/dipm-installed-programs |
    xargs -d'\n' dipm install

mkdir -p "$HOME/repo/own"
mkdir -p "$HOME/repo/forks"
git clone --recursive "https://github.com/Hejsil/aniz.git" "$HOME/repo/own/aniz"
git clone --recursive "https://github.com/Hejsil/cache.git" "$HOME/repo/own/cache"
git clone --recursive "https://github.com/zigtools/zls.git" "$HOME/repo/forks/zls"

local/script/update
