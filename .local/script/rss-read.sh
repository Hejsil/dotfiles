#!/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program"
}

while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

tmp=$(mktemp)
tab=$(printf '\t')
rss-list.sh -u |
    cut -f1,3,4,7,8 |
    awk -F"$tab" '{ printf "%-60s\t%-20s\t%s\t%s\t%s\n", substr($2, 0, 60), substr($4, 0, 20), $1, $3, $5 }' |
    fzf >"$tmp"

if [ -s "$tmp" ]; then
    cut -f4,5 "$tmp" | sed 's/\t$//' | rev | cut -f1 | rev | xargs setsid -f open
    cut -f3 "$tmp" | xargs -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$tmp"
