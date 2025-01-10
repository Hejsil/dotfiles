#!/bin/sh -e

grep '^XDG_' ~/.config/user-dirs.dirs |
    cut -d'"' -f2 |
    sed "s#\$HOME#$HOME#" |
    xargs -d'\n' mkdir -p
