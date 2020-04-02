#!/bin/sh
here="$(dirname "$(realpath "$0")")"
cd "$here" || exit 1

find . -type f \
    -not -path './.git/*' \
    -not -path './install.sh' \
    -not -path './image.png' \
    -not -path './README.md' |
while read -r file; do
    mkdir -p "$HOME/$(dirname "$file")"
    ln -snf "$here/$file" "$HOME/$file"
done
