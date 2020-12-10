#!/usr/bin/env -S sh
echo "$PATH" | tr ':' '\n' | xargs -I% find -L % -type f |
    xargs basename -a | sort -u

