#!/bin/sh

rss-list unread | cut -f1,4 |
    rg -v '^[^\t]*\t(https://(www.)?(youtube|odysee).com)' |
    sort -R | head -n10 | tr '\t' '\n' |
    exec nargs systemd-run --user rss-open-read.sh
