#!/usr/bin/env -S sh

if [ -f "$1" ]; then
    mine=$(file --mime-type -Lb "$1")
    case $mine in
        application/pdf) echo "$READER" ;;
        application/x-bittorrent) echo 'tra.sh' ;;
        inode/x-empty|application/json|text*) echo "$EDITOR" ;;
        image/*) echo 'sxiv -a' ;;
        video/*) echo 'mpv --volume=30 --shuffle' ;;
        audio/*) echo 'mpv --volume=30 --shuffle --vid=no' ;;
        *)
            echo "No match" >&2
            exit 1
            ;;
    esac
else
    case $1 in
        '') echo "$EDITOR" ;;
        *youtube*watch*|*youtube*playlist*|*youtu.be*|*.mp3|*.mp3"?"*|*.mp4|*.mp4"?"*|*.webm|*.webm"?"*)
            echo 'mpv  --volume=30 --shuffle'
        ;;
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

