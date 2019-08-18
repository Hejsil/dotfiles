#!/bin/sh
HERE="$(dirname "$(realpath "$0")")"
cd "$HERE" || exit 1

find . -type f -not -path './.git/*' -not -path './install.sh' | while read -r FILE; do
    mkdir -p "$HOME/$(dirname "$FILE")"
    ln -snf "$HERE/$FILE" "$HOME/$FILE"
done
