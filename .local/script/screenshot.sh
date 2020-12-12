#!/usr/bin/sh
file="$1/$(date '+%y-%m-%dT%H:%M:%S').png"
maim -s "$file" || exit 1
xclip -selection clipboard -t image/png -i "$file"
notify-send 'Screenshot Taken' "$file"
