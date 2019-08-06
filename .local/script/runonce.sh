#!/bin/sh
STR="$@"
STDIN="$(if [ -t 0 ]; then echo ""; else cat; fi)"
pgrep -xf "$STR" || echo "$STDIN" | $@
