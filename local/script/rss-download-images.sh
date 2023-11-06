#!/bin/sh

rss.sh

download_dir="$HOME/downloads/images"
mkdir -p "$download_dir"
cd "$download_dir"
tab=$(printf '\t')

rss-list unread | cut "-d$tab" -f1,3,8 |
    rg '^[^\t]*\t.*https://api.dr.dk/podcasts' |
    rg -v '^[^\t]*\t\d+\. \w{3}\. \d{4} kl\. 12:00' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

names='konachan|pixiv|artstation|danbooru\.donmai|yande'
top_levels='com|net|us|re'
filter="(https?://)(www\.)?($names)\.($top_levels)/(artwork|post)"
image_rss_entries=$(rss-list unread | cut "-d$tab" -f1,4 | rg "^[^\t]*\t.*$filter")
if [ -z "$image_rss_entries" ]; then
    exit
fi

echo "$image_rss_entries" | cut "-d$tab" -f2 | xargs -d'\n' gallery-dl \
    --filter 'vars().get("width", vars().get("image_width", 2560)) >= 2560 and \
    vars().get("height", vars().get("image_height", 1440)) >= 1440' &
echo "$image_rss_entries" | cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/" &
wait
