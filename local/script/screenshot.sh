#!/bin/sh
file="$1/$(date '+%y-%m-%dT%H:%M:%S').png"

selection=$(slop -f "%g") || exit 1
import -window root -crop "$selection" "$file"

xclip -selection clipboard -t image/png -i "$file"
notify-send 'Screenshot Taken' "$file"
