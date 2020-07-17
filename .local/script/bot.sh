#!/bin/sh
folder="$HOME/downloads/discord-bot"
mkdir -p "$folder"

mash_tools listener 'dispatcher' |
    jq --unbuffered -r 'select((.op==0 and .t=="MESSAGE_CREATE")) | .d.content' |
    grep --line-buffered '^::' |
    sed -Eu 's/^:://' |
while read -r command link; do
    case $command in
        p) youtube-dl -f bestaudio --no-playlist --get-id --get-title "$link" |
                sed 's#/#|#g' | {
            read -r name
            read -r id
            file_name="$folder/$name ($id)"
            if ! [ -e "$file_name" ]; then
                youtube-dl -f bestaudio --no-playlist  -o "$file_name" "$link"
            fi

            echo "$file_name"
        } ;;
        s) killall mpv ;;
    esac
done | xargs -n 1 -d'\n' mpv
