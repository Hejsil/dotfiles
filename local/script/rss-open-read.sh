#!/bin/sh

input=$(mktemp)
for arg in "$@"; do
    printf '%s\n' "$arg"
done | paste - - - >"$input"

cut -f2 "$input" | xargs -d '\n' open ||
    cut -f3 "$input" | xargs -d '\n' open || exit 1
cut -f1 "$input" | xargs -d '\n' -I{} mv {} "$HOME/.local/share/rss/read"
exec rm "$input"
