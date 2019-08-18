#!/bin/sh
SET="$1"; [ -z "$SET" ] && echo "No input" && exit 1
sinks.sh | xargs -I{} pactl set-sink-mute {} "$1"
touch /tmp/volume-notify-file
