#!/bin/sh
here="$(dirname "$(realpath "$0")")"
cd "$here" || exit 1

find . -type f -not -path './.git/*' -not -path './install.sh' | while read -r file; do
    mkdir -p "$HOME/$(dirname "$file")"
    ln -snf "$here/$file" "$HOME/$file"
done
