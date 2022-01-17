#!/bin/sh

IFS="$(printf '\t')"
while read -r file mine; do
    case $mine in
        application/pdf) echo "$READER" ;;
        application/x-bittorrent) echo 'tra.sh' ;;
        inode/x-empty | application/json | text*) echo "$EDITOR" ;;
        image/*) echo 'sxiv -a' ;;
        video/*) echo 'mpv' ;;
        audio/*) echo 'mpv --vid=no' ;;
        *) case $file in
            '') echo "$EDITOR" ;;
            *youtube*watch* | *youtube*playlist* | *youtu.be* | *odysee.com* | *.mp3 | *.mp3"?"* | *.mp4 | *.mp4"?"* | *.webm | *.webm"?"*)
                echo 'mpv'
                ;;
            file:* | https:* | http:* | www:*) echo "$BROWSER" ;;
            magnet:*) echo 'tra.sh' ;;
            *:*)
                echo "${1%%:*}"
                ;;
            *)
                echo "No match '$file' '$mine'" >&2
                exit 1
                ;;
        esac ;;
    esac
done
