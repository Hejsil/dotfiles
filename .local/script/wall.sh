#!/bin/sh

set -e

PROGRAM=${0##*/}
usage() {
    echo "Usage: $PROGRAM [ -t TIME ] [ -m MONITORS ] FOLDER"
}

TIME='1m'
while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -t|--time) shift; TIME=$1 ;;
        -m|--monitor) shift; MONITORS=$1 ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

FOLDER=$1; [ -z "$FOLDER" ] && { echo 'No folder provided' >&2; exit 1; }
[ -z "$MONITORS" ] && MONITORS=$(xrandr | grep ' connected' | wc -l)
[ -z "$MONITORS" ] && { echo 'No amount of monitors specified' >&2; exit 1; }

# TODO: Actually use MONITORS variable
TMP=$(mktemp)
while true; do
    find "$FOLDER" -type f >"$TMP" || exit 1
    sort -R "$TMP"
done | paste - - | while IFS=$(printf '\t') read -r FIRST SECOND; do
    if [ "$FIRST" = "$SECOND" ]; then
        continue
    fi

    feh --no-fehbg --bg-fill "$FIRST" "$SECOND"
    sleep "$TIME"
done
