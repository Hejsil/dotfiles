#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
}

FPS="60"
while getopts "f:" OPT; do
    case "$OPT" in
    f)
        FPS="$OPTARG"
        ;;
    *)
        echo "Usage: record.sh [-f <FPS>] <FILE>"
        exit 1
        ;;
    esac
done
shift "$((OPTIND - 1))"

OUTPUT="$1"
[ -z "$OUTPUT" ] && OUTPUT="out.mp4"

slop -f "%x %y %w %h" | (
    read -r X Y W H
    ffmpeg -f x11grab -s "${W}x${H}" -i ":0.0+${X},${Y}" -r "$FPS" -vcodec libx264 "$OUTPUT"
)
