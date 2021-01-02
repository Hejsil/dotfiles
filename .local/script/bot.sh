#!/bin/sh -x
folder="$HOME/.cache/bot"
music_folder="$folder/music"
video_folder="$folder/video"
queue="$folder/queue"
playing="$folder/playing"
mpv_socket="/tmp/mpvsocket"

mkdir -p "$music_folder"
mkdir -p "$video_folder"

printf '' > "$queue"
function queue_pop() {
    res=$(head -n1 "$queue")
    sed -i '1d' "$queue"
    printf '%s\n' "$res"
}

function download() {
    cmd=$1
    link=$2
    IFS=$(printf '\a')
    format="$(echo "$cmd" | sed -E -e 's/pt?/bestaudio/' -e 's/vt?/best/')"
    download_folder="$(echo "$cmd" | sed -E -e 's/pt?/music/' -e 's/vt?/video/')"
    template="$folder/$download_folder/%(title)s %(id)s ($format)"
    youtube-dl -i -f "$format" -o "${template}${IFS}%(id)s" --get-filename "$link" |
    while read -r file_name id; do
        if ! [ -e "$file_name" ]; then
            youtube-dl -i -f "$format" -o "$template" "$id" >&2
        fi
        printf '%s\n' "$file_name"
    done

}

IFS=$(printf '\t')
rg --line-buffered -o '!(\w+)\s*([^ ]*)' -r "\$1$(printf '\t')\$2" |
while read -r cmd link; do
    printf "!%s %s\n" "$cmd" "$link"
    case $cmd in
        p|v)
            download "$cmd" "$link" | cat "$queue" - | sponge "$queue"
            ;;
        pt|vt)
            download "$cmd" "$link" | cat - "$queue" | sponge "$queue"
            ;;
        s)
            printf '{ "command": ["stop"] }\n' |
                socat -u - "$mpv_socket"
            ;;
    esac
done &

mpv "--input-ipc-server=$mpv_socket" --force-window --idle --loop-playlist=no &

while ! printf '' | socat -u "$mpv_socket" -; do :; done |
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

    printf '%s\n' "$file_name" > "$playing"
    printf '{ "command": ["loadfile", "%s"] }\n' "$file_name" |
        socat -u - "$mpv_socket"
done

printf "Yikes!\n"
wait

