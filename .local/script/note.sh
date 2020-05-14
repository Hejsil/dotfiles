#!/bin/sh

program="${0##*/}"
usage() {
    echo "Usage: "
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

date=$(date '+%Y-%m-%d')
file="$date.md"
[ -f "$file" ] || {
    echo "# $date" >>"$file"
    echo '' >>"$file"
    echo '* [ ] ' >>"$file"
}

$EDITOR "$file"
