#!/bin/sh

NOISE="0"
SCALE="2"
TILE="400"

while getopts "n:s:t:h" OPT; do
    case "$OPT" in
        n) NOISE="$OPTARG" ;;
        s) SCALE="$OPTARG" ;;
        t) TILE="$OPTARG" ;;
        h) 
            waifu2x-ncnn-vulkan --help
            exit 0
            ;;
        *) ;;
    esac
done
shift $((OPTIND-1))

TMP="$(mktemp '/tmp/tmp.XXXXXXXXXX')"

find "$@" -type f | while read -r FILE; do
    waifu2x-ncnn-vulkan -i "$FILE" -o "$TMP" -n "$NOISE" -s "$SCALE" -t "$TILE"
    printf "%s\n%s\n" "$FILE" "$TMP" | sxiv -fo - | xargs -I{} cp '{}' "$FILE"
done
