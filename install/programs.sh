#!/bin/sh -e

cd "$(dirname "$0")" || exit 1

sudo pacman -S paru --confirm --needed
paru -S --confirm --needed - <"config/essential-programs"
paru -S --confirm --needed - <"config/installed-programs" || true

mkdir -p "$HOME/repo/own"
mkdir -p "$HOME/repo/forks"
git clone --recursive "https://github.com/Hejsil/aniz.git" "$HOME/repo/own/aniz"
git clone --recursive "https://github.com/Hejsil/cache.git" "$HOME/repo/own/cache"
git clone --recursive "https://github.com/zigtools/zls.git" "$HOME/repo/forks/zls"
git clone --recursive "https://github.com/andrewrk/poop.git" "$HOME/repo/forks/poop"

local/script/update
