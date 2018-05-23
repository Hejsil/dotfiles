#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

for dotfile in $(find "$SCRIPTPATH" -maxdepth 1 -name ".?*"); do
    if [[ "$dotfile" != *.git ]]; then
        ln -s "$dotfile" "$HOME/"
    fi
done
