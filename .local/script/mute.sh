#!/bin/sh
SET=$1
if [ -z "$SET" ]; then
    echo 'No input' >&2
    exit 1
fi

sinks.sh | xargs -I{} pactl set-sink-mute {} "$1"
touch /tmp/volume-notify-file
