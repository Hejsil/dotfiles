#!/bin/sh
curl 'https://www.googleapis.com/youtube/v3/subscriptions?pageToken=CDIQAQ&part=snippet%2CcontentDetails&channelId=UCch55ju1FlFdcDGQuMdRnxg&maxResults=50&key=AIzaSyBu8YAifpfHVbBR2wSbZ5a0Dp6WGEshy88' |
    jq -r '.items[].snippet.resourceId.channelId' |
    sed 's#^#https://www.youtube.com/feeds/videos.xml?channel_id=#'
