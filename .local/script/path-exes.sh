#!/bin/sh
echo "$PATH" | tr ':' '\n' | xargs -I% find -L % -type f 2>/dev/null |
    xargs basename -a | sort -u

