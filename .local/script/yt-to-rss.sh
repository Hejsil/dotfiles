#!/bin/sh
grep 'channel-info' | cut -d'"' -f6 | cut -d"/" -f3 | sed -E 's#(.*)#https://www.youtube.com/feeds/videos.xml?channel_id=\1#g' | sort