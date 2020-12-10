#!/usr/bin/env -S sh

program="${0##*/}"
usage() {
    echo "Usage: "
}

chat_dir='/tmp/twitch'
while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -h|--help) usage; exit 0 ;;
        -a|--auth) shift; auth=$1 ;;
        -c|--channel) shift; channel=$1 ;;
        -n|--nick) shift; nick=$1 ;;
        -d|--dir) shift; char_dir=$1 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

chat_file="$chat_dir/$channel"
mkdir -p "$chat_dir"
printf "" > "$chat_file"

{
    echo ":JOIN #$channel"
    sleep 100d
    #tail -f "$chat_file" >/dev/null
} | sic -h 'irc.chat.twitch.tv' -p '6667' -n "$nick" -k "$auth" >> "$chat_file"

