#!/bin/sh
SET="$1"; [ -z "$SET" ] && echo "No volume" && exit 1
sinks.sh | xargs -I{} pactl set-sink-volume {} "$1"
touch /tmp/volume-notify-file
