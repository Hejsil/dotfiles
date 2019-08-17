#!/bin/sh
EXT="$1"; [ -z "$EXT" ] && echo "No ext" && exit 1

shift
for FILE in "$@"; do (
    REAL="$(realpath "$FILE")"
    cd "$(dirname "$REAL")" || exit 1

    if ( git rev-parse --is-inside-work-tree 2>&1 ) >/dev/null; then
        git mv -- "$REAL" "${REAL%.*}.$EXT" || mv -- "$REAL" "${REAL%.*}.$EXT"
    else
        mv -- "$REAL" "${REAL%.*}.$EXT"
    fi
) done
