#!/bin/sh


PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
}

NOISE="0"
SCALE="2"
TILE="400"
while getopts "n:s:t:h" OPT; do
    case "$OPT" in
        n) NOISE="$OPTARG" ;;
        s) SCALE="$OPTARG" ;;
        t) TILE="$OPTARG" ;;
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

TMP="$(mktemp)"
find "$@" -type f | while read -r FILE; do
    waifu2x-ncnn-vulkan -i "$FILE" -o "$TMP" -n "$NOISE" -s "$SCALE" -t "$TILE"
    printf "%s\n%s\n" "$FILE" "$TMP" | sxiv -fo - | xargs -I{} cp '{}' "$FILE"
done
rm "$TMP"
