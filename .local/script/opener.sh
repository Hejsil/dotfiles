#!/bin/sh

if [ -f "$1" ]; then
    MINE="$(file --mime-type -Lb "$1")"
    case "$MINE" in
        application/pdf) echo "$READER" ;;
        application/x-bittorrent) echo "deluge" ;;
        inode/x-empty|application/json|text*) echo "$EDITOR" ;;
        image/*) echo 'sxiv' ;;
        audio/*) echo 'mpv' ;;
        *)
            >&2 echo "No match"
            exit 1
            ;;
    esac
else
    case "$1" in
        *youtube*watch*|*youtu.be*) echo 'mpv' ;;
        http*|www*) echo "$BROWSER" ;;
        *)
            >&2 echo "No match"
            exit 1
            ;;
    esac
fi
