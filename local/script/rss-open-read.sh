#!/bin/sh

input=$(mktemp -t rss-open-read.XXXXXXXXXX)
for arg in "$@"; do
    printf '%s\n' "$arg"
done | paste - - >"$input"

cut -f2 "$input" | sed 's/^/--new-tab\n/' | nargs -r systemd-run --user browser
cut -f1 "$input" | nargs -I{} mv {} "$HOME/.local/share/rss/read"
exec rm "$input"
