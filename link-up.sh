#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

for dotfile in $(find "$SCRIPTPATH" -maxdepth 1 -name ".?*"); do
    if [[ "$dotfile" != *.git ]]; then
        ln -s "$dotfile" "$HOME/"
    fi
done

# Setup global git ignore
ln -s "$SCRIPTPATH/global-gitignore" "$HOME/.gitignore"
git config --global core.excludesfile "$HOME/.gitignore"
