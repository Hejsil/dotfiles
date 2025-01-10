#!/bin/sh -e

mkdir -p ~/.local/share/bash/

grep '^XDG_' ~/.config/user-dirs.dirs |
    cut -d'"' -f2 |
    sed "s#\$HOME#$HOME#" |
    xargs -d'\n' mkdir -p
