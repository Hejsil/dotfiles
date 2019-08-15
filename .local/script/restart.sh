#!/bin/sh
STDIN="$(if [ -t 0 ]; then echo ""; else cat; fi)"
pgrep -xf "$*" | xargs -I{} kill {}
while pgrep -xf "$STR"; do
    :;
done

echo "$STDIN" | "$@"
