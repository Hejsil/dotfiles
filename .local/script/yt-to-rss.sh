#!/bin/sh
# TODO: Factor out key
KEY="AIzaSyBu8YAifpfHVbBR2wSbZ5a0Dp6WGEshy88"
TMP="$(mktemp)"
PAGETOKEN=""

while true; do
    curl "https://www.googleapis.com/youtube/v3/subscriptions?pageToken=$PAGETOKEN&part=snippet%2CcontentDetails&channelId=UCch55ju1FlFdcDGQuMdRnxg&maxResults=50&key=$KEY" > "$TMP"
    jq -r '.items[].snippet | (.resourceId.channelId, .title)' < "$TMP" | paste - -
    PAGETOKEN="$(jq -r '.nextPageToken' < "$TMP")"
    [ "$PAGETOKEN" = "null" ] && break
done | sed 's#^#https://www.youtube.com/feeds/videos.xml?channel_id=#'

rm "$TMP"
