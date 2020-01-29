#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM") [ -t TIME ] [ -m MONITORS ] FOLDER"
    exit "$1"
}

MONITORS=""
TIME="1m"
while getopts "ht:m:" OPT; do
    case "$OPT" in
        t) TIME="$OPTARG" ;;
        m) MONITORS="$OPTARG" ;;
        h) usage 0 ;;
        *) usage 1 ;;
    esac
done
shift $((OPTIND-1))

FOLDER="$1"; [ -z "$FOLDER" ] && { echo "No folder provided"; exit 1; }
[ -z "$MONITORS" ] && MONITORS="$(xrandr | grep ' connected' | wc -l)"
[ -z "$MONITORS" ] && { echo "No amount of monitors specified"; exit 1; }

# TODO: Actually use MONITORS variable

TMP="$(mktemp)"

while true; do
    find "$FOLDER" -type f >"$TMP" || exit 1
    sort -R "$TMP"
done | paste - - | while IFS="$(printf '\t')" read -r FIRST SECOND; do
    if [ "$FIRST" = "$SECOND" ]; then
        continue
    fi

    feh --no-fehbg --bg-fill "$FIRST" "$SECOND"
    sleep "$TIME"
done
