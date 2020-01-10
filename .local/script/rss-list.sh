#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM") [ -hru ]"
    exit "$1"
}

READ=''
UNREAD=''
while getopts "hru" OPT; do
    case "$OPT" in
        r) READ='read' ;;
        u) UNREAD='unread' ;;
        h) usage 0 ;;
        *) usage 1 ;;
    esac
done
shift $((OPTIND-1))

list_feed() {
    [ -z "$1" ] && return
    find "$HOME/.cache/rss/$1/" -type f -exec awk '
        BEGINFILE { printf "%s", FILENAME }
        {printf "\t%s", $0}
        ENDFILE {printf "\n"}' {} +
}

list_feed "$READ"
list_feed "$UNREAD"
