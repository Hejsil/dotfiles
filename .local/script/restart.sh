#!/bin/sh
STDIN="$(if [ -t 0 ]; then echo ""; else cat; fi)"

DIR="/tmp/processes"
FILE="$DIR/$(echo "$@" | sed 's#/#|#g')"
mkdir -p "$DIR"
[ -e "$FILE" ] && kill "$(cat "$FILE")"

echo "$STDIN" | "$@" &
echo "$!" >"$FILE"
