#!/bin/sh
EXT="$1"; [ -z "$EXT" ] && echo "No ext" && exit 1

shift
for FILE in "$@"; do
    REAL="$(realpath "$FILE")"
    RENAME="${REAL%.*}.$EXT"
    cd "$(dirname "$REAL")" || continue

    if ( git rev-parse --is-inside-work-tree 2>&1 ) >/dev/null; then
        git mv -- "$REAL" "$RENAME" || mv -- "$REAL" "$RENAME" || continue
    else
        mv -- "$REAL" "$RENAME" || continue
    fi
    echo "$REAL -> $RENAME"
done
