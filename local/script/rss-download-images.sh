#!/bin/sh

rss.sh

download_dir="$HOME/downloads/images"
mkdir -p "$download_dir"
cd "$download_dir"
tab=$(printf '\t')

filter="www\.(pixiv\.net|artstation\.com)/artwork"
image_rss_entries=$(rss-list unread | cut "-d$tab" -f1,4 | rg "^[^\t]*\t.*$filter")
if [ -z "$image_rss_entries" ]; then
    exit
fi

echo "$image_rss_entries" | cut "-d$tab" -f2 | xargs -d'\n' gallery-dl || exit 1
echo "$image_rss_entries" | cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"
