#!/bin/sh

PROGRAM=${0##*/}
usage() {
    echo "Usage: $PROGRAM"
    echo "renames the files extention to match the files type"
}

while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

for FILE in "$@"; do
    EXT=$(file --extension "$FILE" | rev | cut -d':' -f 1 | rev | cut -d'/' -f1 | sed 's/ //g')
    ext-mv.sh "$EXT" "$FILE"
done
