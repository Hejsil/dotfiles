#!/bin/sh
EXT=$1
if [ -z "$EXT" ]; then
    echo 'No ext' >&2
    exit 1
fi

shift
for FILE in "$@"; do
    REAL=$(realpath "$FILE")
    RENAME=${REAL%.*}.$EXT
    cd "$(dirname "$REAL")" || continue

    if ( git rev-parse --is-inside-work-tree 2>&1 ) >/dev/null; then
        git mv -- "$REAL" "$RENAME" || continue
    else
        mv -- "$REAL" "$RENAME" || continue
    fi
    echo "$REAL -> $RENAME"
done
