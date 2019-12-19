#!/bin/sh

while getopts "h" OPT; do
    case "$OPT" in
        h)
            echo "usage: $(basename "$0") FILE..."
            echo "renames the files extention to match the files type"
            ;;
        *)
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

for FILE in "$@"; do
    EXT="$(file -i "$FILE" | cut -d' ' -f2 | rev | cut -d'/' -f1 | cut -d';' -f2 | rev)"
    ext-mv.sh "$EXT" "$FILE"
done
