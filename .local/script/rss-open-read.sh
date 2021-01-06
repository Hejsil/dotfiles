#!/bin/sh

input=$(while [ -n "$1" ] && [ -n "$2" ]; do
    printf '%s\t%s\n' "$1" "$2"
    shift; shift
done)
printf '%s' "$input" | cut -f2 | xargs -d '\n' open || exit 1
printf '%s' "$input" | cut -f1 | xargs -d '\n' -I{} mv {} "$HOME/.cache/rss/read"

