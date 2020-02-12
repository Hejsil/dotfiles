#!/bin/sh
SET=$1

if [ -z "$SET" ]; then
    echo 'No volume' >&2
    exit 1
fi

sinks.sh | xargs -I{} pactl set-sink-volume {} "$1"
touch /tmp/volume-notify-file
