#!/bin/sh -e

exe="$(realpath "$0")"
here="$(dirname "$exe")/.."

source "$here/config/env"

git_clone() {
    git clone --depth 1 --shallow-submodules --recursive "$@"
}

install_paru() {
    if command -v paru; then
        return
    fi

    folder="$(mktemp -d)"

    sudo pacman -Syu
    sudo pacman -S --needed base-devel git
    [ -e "$folder" ] && rm -rf "$folder"
    git_clone 'https://aur.archlinux.org/paru.git' "$folder"

    cd "$folder"
    makepkg -si --noconfirm
    paru -S paru-bin
}

install_zig() {
    if command -v "$1"; then
        return
    fi

    repo="$1"
    folder="$HOME/repo/own/st-flexipatch"

    rm -rf "$folder"
    mkdir -p "$folder"

    git_clone "https://github.com/Hejsil/$repo.git" "$folder"
    zig build --build-file "$folder/build.zig" -Drelease-safe &&
        sudo zig build --build-file "$folder/build.zig" -Drelease-safe --prefix "$HOME/.local"
}

install_st() {
    if command -v st; then
        return
    fi

    folder="$HOME/repo/forks/st-flexipatch"
    rm -rf "$folder"
    mkdir -p "$folder"
    git_clone 'https://github.com/bakkeby/st-flexipatch.git' "$folder"

    cd "$folder"
    rm config.def.h patches.def.h config.mk Makefile
    ln -sf "$here/config/st-flexipatch/config.def.h" 'config.def.h'
    ln -sf "$here/config/st-flexipatch/patches.def.h" 'patches.def.h'
    ln -sf "$here/config/st-flexipatch/config.mk" 'config.mk'
    ln -sf "$here/config/st-flexipatch/Makefile" 'Makefile'

    make install PREFIX="$HOME/.local"
}

install_paru
paru -S --confirm --needed - <"$here/config/installed-programs"

install_zig 'aniz'
install_zig 'cache'
install_zig 'lemonbar-maker'

install_st
