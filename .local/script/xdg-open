#!/bin/sh

ARG="$1"; [ -z "$ARG" ] && exit 1

name_match() {
    echo "$ARG" | grep -E "$1"
}

file_match() {
    file "$ARG" | grep -E "$1"
}

if file_match "JPEG|PNG|GIF"; then
    sxiv "$ARG"
elif file_match "Matroska"; then
    mpv "$ARG"
elif file_match "PDF"; then
    zathura "$ARG"
elif name_match "^(https?:\/\/)?(www\.)?youtu(\.be\/.*|be\.com\/watch\?.*v=.*)$"; then
    mpv "$ARG"
else
    echo "No match"
    exit 1
fi
