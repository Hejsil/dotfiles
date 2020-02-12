#!/bin/sh

PROGRAM=${0##*/}
usage() {
    echo "Usage: $PROGRAM"
}

NOISE=0
SCALE=2
TILE=400
while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -n|--noise) shift; NOISE=$1 ;;
        -s|--scale) SCALE=$1 ;;
        -t|--tile) TILE=$1 ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

TMP=$(mktemp)
find "$@" -type f | while read -r FILE; do
    waifu2x-ncnn-vulkan -i "$FILE" -o "$TMP" -n "$NOISE" -s "$SCALE" -t "$TILE"
    printf '%s\n%s\n' "$FILE" "$TMP" | sxiv -fo - | xargs -I{} cp '{}' "$FILE"
done
rm "$TMP"
