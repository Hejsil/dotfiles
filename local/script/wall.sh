#!/bin/sh -e

folder=$1
stack_folder='/tmp/random-wallpapers'

pop() {
    stack pop "$stack_folder" || {
        find "$folder" -type f | sort -R | while read -r file; do
            echo "$file" | stack push "$stack_folder"
        done
        stack pop "$stack_folder"
    }
}

xrandr --listactivemonitors |
    rg -o '^ (\d+): [^ ]+ (\d+)/\d+x(\d+)' -r '$1 $2 $3' |
    while read -r id w h; do
        file=$(pop)
        file=$(cache "$file" -- convert "$file" -resize "${w}x${h}^" -quality 100 'jpg:{{output}}')
        echo '--on'
        echo "$id"
        echo "$file"
    done | xargs -d '\n' setroot
