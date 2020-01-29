#!/bin/sh
FILE="$1/$(date '+%y-%m-%dT%H:%M:%S').png"
maim -s "$FILE" || exit 1
xclip -selection clipboard -t image/png -i "$FILE"
notify-send 'Screenshot Taken' "$FILE"
