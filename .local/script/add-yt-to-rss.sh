#!/usr/bin/sh

channel_id=$1
channel_name=$2

printf "\nhttps://www.youtube.com/feeds/videos.xml?channel_id=%s\t%s\n" "$channel_id" "$channel_name" >> "$HOME/.config/rss/urls"
sort -u "$HOME/.config/rss/urls" | sponge "$HOME/.config/rss/urls"

