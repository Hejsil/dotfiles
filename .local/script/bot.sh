#!/bin/sh
folder="$HOME/.cache/bot"
music_folder="$folder/music"
video_folder="$folder/video"
queue="$folder/queue"
playing="$folder/playing"
mpv_socket="/tmp/mpvsocket"

mkdir -p "$music_folder"
mkdir -p "$video_folder"

printf '' >"$queue"
queue_pop() {
    res=$(head -n1 "$queue")
    sed -i '1d' "$queue"
    printf '%s\n' "$res"
}

download() {
    user=$1
    cmd=$2
    link=$3

    case "$cmd" in
        p | pt)
            format="bestaudio"
            download_folder="music"
            ;;
        v | vt)
            format="best"
            download_folder="video"
            ;;
        *) return ;;
    esac

    IFS=$(printf '\a')
    template="$folder/$download_folder/%(title)s [%(creator)s] %(id)s ($format)"
    youtube-dl -i -f "$format" -o "${template}${IFS}%(id)s${IFS}%(license)s${IFS}%(title)s" --get-filename "$link" |
        while read -r file_name id license title; do
            if [ "${license#*Creative Commons}" == "$license" ]; then
                notify-send "Invalid license!" "$(printf '%s\n%s\n%s\n' \
                    "$user" "$title" "$license")"
                continue
            fi

            if ! [ -e "$file_name" ]; then
                youtube-dl -i -f "$format" -o "$template" "$id" >&2
            fi
            printf '%s\n' "$file_name"
            notify-send "Song queued" "$(printf '%s\n%s\n' \
                "$user" "$title")"
        done

}

IFS=$(printf '\t')
rg --line-buffered -o '([^ ]+)\s+!(\w+)\s+([^ ]*)' -r "\$1${IFS}\$2${IFS}\$3" |
    while read -r user cmd link; do
        printf "!%s %s\n" "$cmd" "$link"
        case $cmd in
            p | v) download "$user" "$cmd" "$link" | cat "$queue" - | sponge "$queue" ;;
            pt | vt) download "$user" "$cmd" "$link" | cat - "$queue" | sponge "$queue" ;;
            s) printf '{ "command": ["stop"] }\n' | socat -u - "$mpv_socket" ;;
        esac
    done &

mpv "--input-ipc-server=$mpv_socket" --force-window --idle --loop-playlist=no &

while ! printf '' | socat -u "$mpv_socket" - 2>/dev/null; do :; done |
    rg --line-buffered -F '{"event":"idle"}' |
    while read -r _; do
        file_name=$(queue_pop)

        # If no file has been queue, then we pick a file that we have already
        # downloaded at random.
        while [ -z "$file_name" ]; do
            file_name=$(find "$music_folder" -type f | sort -R | head -n1)

            # We might not have downloaded any files yet. Wait for changes
            # to the folder and try again.
            [ -z "$file_name" ] && inotifywait "$music_folder"
        done

        printf '%s\n' "$file_name" >"$playing"
        printf '{ "command": ["loadfile", "%s"] }\n' "$file_name" |
            socat -u - "$mpv_socket"
        title=$(basename "$file_name" | rg '^(.*) \[(.+)\] [^ ]+ \(\w+\)$' -r "$(printf '$1\n$2')")
        notify-send "Now playing" "$title"
    done

printf "Yikes!\n"
wait
