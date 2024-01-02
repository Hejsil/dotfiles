#!/bin/sh

rss.sh

# download_dir="$HOME/downloads/images"
# mkdir -p "$download_dir"
# cd "$download_dir"
tab=$(printf '\t')

rss-list unread | cut "-d$tab" -f1,3,8 |
    rg '^[^\t]*\t.*https://api.dr.dk/podcasts' |
    rg -v '^[^\t]*\t\d+\. \w{3}\. \d{4} kl\. 12:00' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

rss-list unread |
    rg '^[^\t]*\t\d+\t[^\t]* (opened|closed) task #\d+:' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

rss-list unread |
    rg '^[^\t]*\t\d+\t[^\t]* (added|removed) design #\d+' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

rss-list unread |
    rg '^[^\t]*\t\d+\t[^\t]* updated wiki page[^\t]*in[^\t]*' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

rss-list unread |
    rg '^[^\t]*\t\d+\t[^\t]* left project [^\t]*' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

rss-list unread |
    rg '^[^\t]*\t\d+\t[^\t]* joined project [^\t]*' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

rss-list unread |
    rg '^[^\t]*\t\d+\t[^\t]* pushed to project branch \d+' |
    cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/"

# names='konachan|pixiv|artstation|danbooru\.donmai|yande|e-shuushuu'
# top_levels='com|net|us|re'
# filter="(https?://)(www\.)?($names)\.($top_levels)/(artwork|post|images)"
# image_rss_entries=$(rss-list unread | cut "-d$tab" -f1,4 | rg "^[^\t]*\t.*$filter")
# if [ -z "$image_rss_entries" ]; then
#     exit
# fi

# echo "$image_rss_entries" | cut "-d$tab" -f2 | xargs -d'\n' gallery-dl &
# --filter 'vars().get("width", vars().get("image_width", 2560)) >= 2560 and
# vars().get("height", vars().get("image_height", 1440)) >= 1440'
# echo "$image_rss_entries" | cut "-d$tab" -f1 | xargs -d'\n' -I% mv % "$HOME/.local/share/rss/read/" &
wait
