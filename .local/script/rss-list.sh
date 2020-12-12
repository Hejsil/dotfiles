#!/usr/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program"
}

while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -r|--read) read='read' ;;
        -u|--unread) unread='unread' ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

list_feed() {
    [ -z "$1" ] && return
    find "$HOME/.cache/rss/$1/" -type f -exec awk '
        BEGINFILE { printf "%s", FILENAME }
        { printf "\t%s", $0 }
        ENDFILE { printf "\n" }' {} +
}

list_feed "$read"
list_feed "$unread"
