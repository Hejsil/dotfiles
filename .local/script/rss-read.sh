#!/usr/bin/sh

tmp=$(mktemp)
tab=$(printf '\t')
rss-list.sh -u |
    awk -F"$tab" '{ printf "%-60s\t%-15s\t%s\t%s\t%s\n", substr($3, 0, 60), substr($7, 0, 15), $1, $4, $8 }' |
    fzf -m -d '\t' --with-nth=1,2 >"$tmp"

if [ -s "$tmp" ]; then
    choose -f '\t' -1 -i "$tmp" | xargs -d '\n' opener.sh || exit 1
    choose -f '\t' -1 -i "$tmp" | xargs -d '\n' setsid -f open
    choose -f '\t'  2 -i "$tmp" | xargs -d '\n' -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$tmp"
