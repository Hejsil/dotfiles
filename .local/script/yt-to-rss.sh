#!/bin/sh
# TODO: Make general
url='https://www.googleapis.com/youtube/v3/subscriptions'
key='AIzaSyBu8YAifpfHVbBR2wSbZ5a0Dp6WGEshy88'
channel_id='UCch55ju1FlFdcDGQuMdRnxg'
tmp=$(mktemp)
pagetoken=

while true; do
    curl -s "${url}?pageToken=${page_token}&part=snippet%2CcontentDetails&channelId=${channel_id}&maxResults=50&key=${key}" > "$tmp"
    jq -r '.items[].snippet | (.resourceId.channelId, .title)' < "$tmp" | paste - -
    page_token=$(jq -r '.nextPageToken' < "$tmp")
    [ "$page_token" = 'null' ] && break
done | sed 's#^#https://www.youtube.com/feeds/videos.xml?channel_id=#'

rm "$tmp"
