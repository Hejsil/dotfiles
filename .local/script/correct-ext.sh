#!/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program"
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

for file in "$@"; do
    ext=$(file --extension "$file" | rev | cut -d':' -f 1 | rev | cut -d'/' -f1 | sed 's/ //g')
    ext-mv.sh "$ext" "$file"
done
