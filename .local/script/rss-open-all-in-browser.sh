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
rss-list.sh -u | cut -f1,4,8 |
while IFS=$tab read -r file link enclosure; do
    printf '%s\t%s\t%s\t%s\n' "$(opener.sh "$link")" "$file" "$link" "$enclosure"
done | grep "^$BROWSER" | cut -f2,3,4 | head -n 50 >"$tmp"

if [ -s "$tmp" ]; then
    cut -f2,3 "$tmp" | sed 's/\t$//' | rev | cut -f1 | rev | tr '\n' ' ' | xargs daemonize.sh "$BROWSER"
    cut -f1 "$tmp" | xargs -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$tmp"
