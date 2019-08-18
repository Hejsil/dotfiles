#!/bin/sh

# Load theme from .Xresources
eval "$(grep 'color[0-9]*:[ ]*#' "$HOME/.Xresources" | sed -E 's/^\*color([0-9]*):[ ]*(.*)$/COLOR\1="\2"/')"

bar-info.sh | bar-mk.sh | lemonbar  \
    -f 'monospace:size=17'          \
    -B "$COLOR0"                    \
    -F "$COLOR15"                   \
    -u '2'                          \
    -o '1'
