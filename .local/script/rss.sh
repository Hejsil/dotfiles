#!/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program [-h]"
    echo '    -h    Print help information and exists'
}

while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

dir_with_fallback() {
    dir=$1
    fallback=$2
    if [ -e "$dir" ]; then
        echo "$dir"
    else
        echo "$fallback"
    fi
}

global_cache_dir=$(dir_with_fallback "$XDG_CACHE_HOME" "$HOME/.cache")
global_config_dir=$(dir_with_fallback "$XDG_CONFIG_HOME" "$HOME/.config")

# cache dirs
cache_dir="$global_cache_dir/rss";
unread_dir="$cache_dir/unread"; mkdir -p "$unread_dir"
read_dir="$cache_dir/read"; mkdir -p "$read_dir"

# configs
config_dir="$global_config_dir/rss"; mkdir -p "$config_dir"
url_config="$config_dir/urls"; touch -a "$url_config"

while read -r line _; do
    echo "$line" >&2
    curl -s "$line" | sfeed | tr '\t' '\a'
done < "$url_config" |
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
