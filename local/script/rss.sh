#!/bin/sh

# cache dirs
cache_dir="$XDG_DATA_HOME/rss"
config_dir="$XDG_CONFIG_HOME/rss"
unread_dir="$cache_dir/unread"
read_dir="$cache_dir/read"
url_config="$config_dir/urls"

mkdir -p "$read_dir" "$unread_dir" "$config_dir"
touch -a "$url_config"

IFS=$(printf '\a')
rss-download-feed "$url_config" | sfeed | tr '\t' '\a' |
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

# This read that are older than 10d will be deleted.
fd . "$read_dir" --older 10d -x rm
