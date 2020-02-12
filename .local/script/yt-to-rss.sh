#!/bin/sh
# TODO: Make general
URL='https://www.googleapis.com/youtube/v3/subscriptions'
KEY='AIzaSyBu8YAifpfHVbBR2wSbZ5a0Dp6WGEshy88'
CHANNELID='UCch55ju1FlFdcDGQuMdRnxg'
TMP=$(mktemp)
PAGETOKEN=

while true; do
    curl -s "${URL}?pageToken=${PAGETOKEN}&part=snippet%2CcontentDetails&channelId=${CHANNELID}&maxResults=50&key=${KEY}" > "$TMP"
    jq -r '.items[].snippet | (.resourceId.channelId, .title)' < "$TMP" | paste - -
    PAGETOKEN=$(jq -r '.nextPageToken' < "$TMP")
    [ "$PAGETOKEN" = 'null' ] && break
done | sed 's#^#https://www.youtube.com/feeds/videos.xml?channel_id=#'

rm "$TMP"
