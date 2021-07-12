#!/bin/sh

# cache dirs
cache_dir="$XDG_DATA_HOME/rss"
config_dir="$XDG_CONFIG_HOME/rss"
unread_dir="$cache_dir/unread"
read_dir="$cache_dir/read"
url_config="$config_dir/urls"

mkdir -p "$read_dir" "$unread_dir" "$config_dir"
touch -a "$url_config"

cut -f1 "$url_config" | xargs curl -sZ | sfeed | tr '\t' '\a' |
    while IFS=$(printf '\a') read -r timestamp title link content content_type id author enclosure; do
        id=$(echo "$id" | sed 's#/#|#g')
        [ -z "$id" ] && id=$(echo "$link" | sed 's#/#|#g')
        [ -z "$id" ] && {
            echo 'No id' >&2
            continue
        }
        [ -e "$unread_dir/$id" ] && continue
        [ -e "$read_dir/$id" ] && continue

        printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n' "$timestamp" "$title" "$link" \
            "$content" "$content_type" "$author" "$enclosure" \
            >"$unread_dir/$id"
    done
