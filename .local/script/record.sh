#!/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program"
}

fps=60
while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -f|--fps) shift; fps=$1 ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

output=$1
[ -z "$output" ] && output="$HOME/video/$(date '+%y-%m-%dT%H:%M:%S').mp4"

echo "$output"
slop -f '%x %y %w %h' | {
    read -r x y w h
    ffmpeg -f x11grab -s "${w}x${h}" -i ":0.0+${x},${y}" -r "$fps" -vcodec libx264 "$output"
}

