#!/bin/sh
ext=$1
if [ -z "$ext" ]; then
    echo 'No ext' >&2
    exit 1
fi

shift
for FILE in "$@"; do
    real=$(realpath "$FILE")
    rename=${real%.*}.$ext
    cd "$(dirname "$real")" || continue

    if ( git rev-parse --is-inside-work-tree 2>&1 ) >/dev/null; then
        git mv -- "$real" "$rename" || continue
    else
        mv -- "$real" "$rename" || continue
    fi
    echo "$real -> $rename"
done
