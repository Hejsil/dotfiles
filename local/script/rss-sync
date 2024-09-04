#!/bin/sh

config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
data_home="${XDG_DATA_HOME:-$HOME/.local/share}"

data_dir="$data_home/rss"
config_dir="$config_home/rss"
unread_dir="$data_dir/unread"
read_dir="$data_dir/read"

urls_file="$config_dir/urls"

mkdir -p "$read_dir" "$unread_dir" "$config_dir"
touch -a "$urls_file"

IFS=$(printf '\t')

{
    zzz-codes-to-sfeed
    rss-download-feed "$urls_file" | sfeed
} |
    while read -r timestamp title link content content_type id author enclosure; do
        id=$(printf '%s-%s-%s' "$id" "$link" "$enclosure" | xxhsum | cut -d' ' -f1)
        [ -e "$unread_dir/$id" ] && {
            touch "$unread_dir/$id"
            continue
        }
        [ -e "$read_dir/$id" ] && {
            touch "$read_dir/$id"
            continue
        }

        printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n' \
            "$timestamp" "$title" "$link" "$content" "$content_type" "$author" "$enclosure" \
            >"$unread_dir/$id"
    done

# Older than 10d posts will be deleted
fd . "$read_dir" --older 10d -x rm
