#!/bin/sh
STDIN=$(if [ -t 0 ]; then echo; else cat; fi)

DIR='/tmp/processes'
FILE="$DIR/$(echo "$@" | sed 's#/#|#g')"
mkdir -p "$DIR"
[ -s "$FILE" ] && [ -e "/proc/$(cat "$FILE")" ] && exit 0

echo "$STDIN" | "$@" &
echo "$!" >"$FILE"
