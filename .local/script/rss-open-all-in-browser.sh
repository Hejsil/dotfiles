#!/usr/bin/sh

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
while IFS=$tab read -r file _ _ link _ _ _ enclosure; do
    printf '%s\t%s\t%s\t%s\n' "$(opener.sh "$link")" "$file" "$link" "$enclosure"
done | grep "^$BROWSER" | head -n 50 >"$tmp"

if [ -s "$tmp" ]; then
    choose -f '\t' -1 -i "$tmp" | xargs -d '\n' opener.sh || exit 1
    choose -f '\t' -1 -i "$tmp" | xargs -d '\n' setsid -f open
    choose -f '\t'  1 -i "$tmp" | xargs -d '\n' -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$tmp"
