#!/bin/sh
folder="$HOME/downloads/discord-bot"
mkdir -p "$folder"

mash_tools listener 'dispatcher' |
    jq --unbuffered -r 'select((.op==0 and .t=="MESSAGE_CREATE")) | .d.content' |
    grep --line-buffered '^::' |
    sed -Eu 's/^:://' |
while read -r command link; do
    case $command in
        p|v)
            format="$(echo "$command" | sed -e 's/p/bestaudio/' -e 's/v/best/')"
            template="$folder/%(title)s %(id)s ($format)"
            file_name="$(youtube-dl --no-playlist -o "$template" --get-filename "$link")"
            if ! [ -e "$file_name" ]; then
                youtube-dl -f "$format" --no-playlist  -o "$template" "$link"
            fi

            echo "$file_name"
            ;;
        s) killall mpv ;;
    esac
done | xargs -n 1 -d'\n' mpv --fullscreen
