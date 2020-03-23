#!/bin/sh

if [ -f "$1" ]; then
    MINE=$(file --mime-type -Lb "$1")
    case $MINE in
        application/pdf) echo "$READER" ;;
        application/x-bittorrent) echo 'tra.sh' ;;
        inode/x-empty|application/json|text*) echo "$EDITOR" ;;
        image/*) echo 'sxiv -a' ;;
        video/*) echo 'mpv' ;;
        audio/*) echo 'mpv --vid=no' ;;
        *)
            echo "No match" >&2
            exit 1
            ;;
    esac
else
    case $1 in
        *youtube*watch*|*youtu.be*) echo 'mpv' ;;
        magnet:*) echo 'tra.sh' ;;
        http*|www*) echo "$BROWSER" ;;
        *:*)
            echo "${1%%:*}"
            ;;
        *)
            echo "No match" >&2
            exit 1
            ;;
    esac
fi

