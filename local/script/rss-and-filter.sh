#!/bin/sh

rss.sh

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

wait
