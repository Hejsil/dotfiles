#!/bin/sh

output=$1
[ -z "$output" ] && output="$HOME/video/$(date '+%y-%m-%dT%H:%M:%S').mp4"

mkdir -p "$(dirname "$output")"
slop -f '%x %y %w %h' | {
    read -r x y w h
    ffmpeg -f x11grab -s "${w}x${h}" -i ":0.0+${x},${y}" -r 60 -vcodec libx264 "$output"
}

output_gif=$(echo "$output" | sed 's/\.[^.]*$/.gif/')
gifgen -o "$output_gif" "$output"
echo "$output"
echo "$output_gif"
