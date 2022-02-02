#!/bin/sh
file="$1/$(date '+%y-%m-%dT%H:%M:%S:%N').png"
import -window root "$file"
xclip -selection clipboard -t image/png -i "$file"
