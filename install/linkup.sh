#!/bin/sh -e

cd "$(dirname "$0")/.." || exit 1

link() {
    if ! [ -L "$2" ] && [ -e "$2" ]; then
        echo "Install script will remove '$2'. Are you sure?" >&2
        rm -rfI "$2"
        [ -e "$2" ] && return 1
    fi

    ln -snf "$1" "$2"
}

mkdir -p "$HOME/repo"

link "$(pwd)/config" "$HOME/.config"
link "$(pwd)/local" "$HOME/.local"
link "$(pwd)/config/bash/profile" "$HOME/.bash_profile"
link "$(pwd)/config/bash/profile" "$HOME/.profile"
link "$(pwd)/config/bash/rc" "$HOME/.bashrc"
link "$(pwd)/config/.clang-tidy" "$HOME/repo/.clang-tidy"
link "$(pwd)/config/perfconfig" "$HOME/.perfconfig"
