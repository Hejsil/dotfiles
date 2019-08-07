#!/bin/sh
STR="$@"
STDIN="$(if [ -t 0 ]; then echo ""; else cat; fi)"
pgrep -xf "$STR" | xargs -I{} kill {}
while pgrep -xf "$STR"; do
    :;
done

echo "$STDIN" | $@
