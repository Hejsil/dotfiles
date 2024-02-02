#!/bin/sh -e

link() {
    if ! [ -L "$2" ] && [ -e "$2" ]; then
        echo "Install script will remove '$2'. Are you sure?" >&2
        rm -rfI "$2"
        [ -e "$2" ] && return 1
    fi

    ln -snf "$1" "$2"
}

cd "$(dirname "$0")/.."
link "$(pwd)/config" "$HOME/.config"
link "$(pwd)/local" "$HOME/.local"
link "$(pwd)/config/profile" "$HOME/.bash_profile"
link "$(pwd)/config/profile" "$HOME/.profile"
link "$(pwd)/config/bashrc" "$HOME/.bashrc"
link "$(pwd)/config/perfconfig" "$HOME/.perfconfig"
