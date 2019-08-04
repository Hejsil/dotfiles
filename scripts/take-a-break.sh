#!/bin/sh
while true; do
    notify-send "$(figlet Back to work)" &
    paplay /usr/share/sounds/freedesktop/stereo/message.oga &
    echo "Working"
    sleep 50m
    notify-send "$(figlet Take a break)"
    paplay /usr/share/sounds/freedesktop/stereo/message.oga &
    echo "Breaking"
    sleep 10m
done