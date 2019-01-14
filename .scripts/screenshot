#!/bin/sh
FILE="$1/$(date '+%y-%m-%dT%H:%M:%S').png"
maim -s > "$FILE"
xclip -selection clipboard -t image/png -i "$FILE"
notify-send 'Screenshot Taken' "$FILE"
