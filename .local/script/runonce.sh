#!/bin/sh
STDIN="$(if [ -t 0 ]; then echo ""; else cat; fi)"
pgrep -xf "$*" || echo "$STDIN" | "$@"
