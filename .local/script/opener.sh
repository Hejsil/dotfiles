#!/bin/sh

if [ -f "$1" ]; then
    mine=$(file --mime-type -Lb "$1")
    case $mine in
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
        '') echo "$EDITOR" ;;
        *youtube*watch*|*youtube*playlist*|*youtu.be*|*twitch.tv*|*.mp3|*.mp3"?"*|*.mp4|*.mp4"?"*|*.webm|*.webm"?"*) echo 'mpv' ;;
        http*|www*) echo "$BROWSER" ;;
        magnet:*) echo 'tra.sh' ;;
        *:*)
            echo "${1%%:*}"
            ;;
        *)
            echo "No match" >&2
            exit 1
            ;;
    esac
fi

