#!/bin/sh
STDIN="$(if [ -t 0 ]; then echo ""; else cat; fi)"

DIR="/tmp/processes"
FILE="$DIR/$1"
mkdir -p "$DIR"
[ -e "$FILE" ] && exit 0

echo "$STDIN" | "$@" &
echo "$!" >"$FILE"
