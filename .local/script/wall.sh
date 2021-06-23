#!/bin/sh -e

folder=$1
monitors=$(xrandr | grep -c ' connected')
find "$folder" -type f | sort -R |
    head -n "$monitors" | sed 's/^/-z\n/' |
    xargs -d '\n' setroot
