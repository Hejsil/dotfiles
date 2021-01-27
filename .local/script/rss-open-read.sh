#!/bin/sh

input=$(for arg in "$@"; do
    printf '%s\n' "$arg"
done | paste - - -)

printf '%s' "$input" | cut -f3 | xargs -d '\n' open ||
    printf '%s' "$input" | cut -f2 | xargs -d '\n' open || exit 1
printf '%s' "$input" | cut -f1 | xargs -d '\n' -I{} mv {} "$HOME/.cache/rss/read"

