#!/bin/sh
HERE="$(dirname "$(realpath "$0")")"
cd "$HERE"

for FILE in $(find -type f -not -path "./.git/*" -not -path "./install.sh"); do
    mkdir -p "$HOME/$(dirname "$FILE")"
    ln -snf "$HERE/$FILE" "$HOME/$FILE"
done
