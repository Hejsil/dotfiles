#!/bin/sh

PROGRAM=${0##*/}
usage() {
    echo "Usage: $PROGRAM"
}

FPS=60
while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -f|--fps) shift; FPS=$1 ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

OUTPUT=$1
[ -z "$OUTPUT" ] && OUTPUT='out.mp4'

slop -f '%x %y %w %h' | {
    read -r X Y W H
    ffmpeg -f x11grab -s "${W}x${H}" -i ":0.0+${X},${Y}" -r "$FPS" -vcodec libx264 "$OUTPUT"
}
