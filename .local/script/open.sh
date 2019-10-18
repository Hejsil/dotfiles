#!/bin/sh

ARG="$1"; [ -z "$ARG" ] && exit 1

name_match() {
    echo "$ARG" | grep -E "$1"
}

mime_match() {
    file -i "$ARG" | grep -E "$1"
}

echo "$ARG" >> /tmp/open.log

if mime_match "application/pdf;"; then
    "$READER" "$ARG"
elif mime_match "text/.*;|application/json"; then
    "$EDITOR" "$ARG"
elif mime_match "image/.*;"; then
    sxiv "$ARG"
elif mime_match "(audio|video)/.*;"; then
    mpv "$ARG"
elif mime_match "application/java-archive;"; then
    java -jar "$ARG"
elif mime_match "application/x-bittorrent;"; then
    deluge "$ARG"
elif name_match "^(https?:\/\/)?(www\.)?youtu(\.be\/.*|be\.com\/watch\?.*v=.*)$"; then
    mpv "$ARG"
elif name_match "^(https?:\/\/)|(www\.)"; then
    "$BROWSER" "$ARG"
else
    echo "No match"
    exit 1
fi
