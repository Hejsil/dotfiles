#!/bin/sh -e

folder=$1
stack_folder='/tmp/wallpapers/stack'
scaled_folder='/tmp/wallpapers/images'

mkdir -p "$scaled_folder"

pop() {
    stack pop "$stack_folder" || {
        find "$folder" -type f | sort -R | while read -r file; do
            echo "$file" | stack push "$stack_folder"
        done
        stack pop "$stack_folder"
    }
}

xrandr --listactivemonitors |
    rg -o '^ \d+: [^ ]+ (\d+)/\d+x(\d+).*  (.+)$' -r '$3 $1 $2' |
    while read -r id w h; do
        file=$(pop)
        scaled="$scaled_folder/$(basename "$file")-$id"
        cache -f "$file" -o "$scaled" -- \
            convert "$file" -resize "${w}x${h}^" -quality 100 "jpg:$scaled"
        echo '--output'
        echo "$id"
        echo '--center'
        echo "$scaled"
    done | xargs -d '\n' xwallpaper
