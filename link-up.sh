#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
SYMLINK="symlink."

for dotfile in $(find "$SCRIPTPATH" -maxdepth 1 -name "$SYMLINK.*"); do
    NAME=$(basename "$dotfile")
    ln -s "$dotfile" "$HOME/${NAME#$SYMLINK}"
done

git config --global core.excludesfile "$HOME/.gitignore"
