#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
}

while getopts "h" OPT; do
    case "$OPT" in
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

DIR="$1"; [ -z "$DIR" ] && { echo "Missing DIR"; exit 1; }
fd '' "$DIR" -Ht f | rofi -dmenu
