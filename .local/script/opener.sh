#!/bin/sh

if [ -f "$1" ]; then
    mine=$(file --mime-type -Lb "$1")
    case $mine in
        application/pdf) echo "swallow $READER" ;;
        application/x-bittorrent) echo 'tra.sh' ;;
        inode/x-empty|application/json|text*) echo "$EDITOR" ;;
        image/*) echo 'swallow sxiv -a' ;;
        video/*) echo 'swallow mpv' ;;
        audio/*) echo 'mpv --vid=no' ;;
        *)
            echo "No match" >&2
            exit 1
            ;;
    esac
else
    case $1 in
        '') echo "$EDITOR" ;;
        *youtube*watch*|*youtube*playlist*|*youtu.be*|*twitch.tv*|*.mp3|*.mp3"?"*|*.mp4|*.mp4"?"*|*.webm|*.webm"?"*) echo 'swallow mpv' ;;
        http*|www*) echo "swallow $BROWSER" ;;
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

