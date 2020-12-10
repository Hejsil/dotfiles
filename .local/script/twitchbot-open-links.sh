#!/usr/bin/env -S sh

channel=$1
browser=$2
chat_dir=$3
chat_file="$chat_dir/$channel"

mkdir -p "$chat_dir"
touch "$chat_file"

tail -n 0 -f "$chat_file" |
    rg --line-buffered -o -v "^($channel\.)?tmi.twitch.tv:" |
    rg --line-buffered -o '(https?://)?(www\.)?(\w*\.)+(\w+)(/[^\s]*)?' |
    xargs -d'\n' -n 1 $browser

