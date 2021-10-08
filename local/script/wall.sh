#!/bin/sh -e

folder=$1
stack_folder='/tmp/random-wallpapers'
monitors=$(xrandr | grep -c ' connected')
seq "$monitors" | while read -r; do
    stack pop "$stack_folder" || {
        find "$folder" -type f | sort -R | while read -r file; do
            echo "$file" | stack push "$stack_folder"
        done
        stack pop "$stack_folder"
    }
done | sed 's/^/-z\n/' | xargs -d '\n' setroot
