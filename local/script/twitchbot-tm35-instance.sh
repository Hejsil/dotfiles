#!/bin/sh

channel=$1
chat_dir=$2
chat_file="$chat_dir/$channel"
tm35_dir=$3
emulator=$4
base_rom=$5
patch_rom=$6

mkdir -p "$chat_dir"
touch "$chat_file"
cd "$tm35_dir" || exit

"$tm35_dir/tm35-load" "$base_rom" |
    twitchbot-tm35.sh "$channel" /tmp/twitch |
    "$tm35_dir/tm35-apply" "$patch_rom" -p live |
    "$emulator"
