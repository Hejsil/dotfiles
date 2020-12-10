#!/usr/bin/env -S sh

program=${0##*/}
usage() {
    echo "Usage: $program"
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

download_dir="$HOME/downloads/images"
mkdir -p "$download_dir"
tmp_template="$download_dir/XXXXXX"

tab=$(printf '\t')
a=$(printf '\a')
rss-list.sh -u | tr "$tab" "$a" | while IFS=$a read -r file _ _ link desc _; do
    case $file in
        *tag:konachan.*)
            curl -s "$link" |
                grep -o 'href="[^"]*" id="highres"' |
                cut -d'"' -f2
            # Also output the link. This is done, so that if the site
            # has no images, it will still be marked as read.
            echo "$link"
            ;;
        *e-shuushuu.net*)
            # shuushuu started using https only, but didn't update their rss feed...
            echo "https:${link#http:}"
            ;;
        *www.artstation.com*)
            echo "$desc" | grep -oE '\w+:\/\/[-a-zA-Z0-9:@;?&=\/%\+\.\*!'"'"'\(\),\$_\{\}\^~`#|]+'
            ;;
        *) case $link in
                *www.reddit.com*)
                    echo "$desc" | grep -oE '\w+:\/\/[-a-zA-Z0-9:@;?&=\/%\+\.\*!'"'"'\(\),\$_\{\}\^~`#|]+'
                    ;;
                *) ;;
            esac
            ;;
    esac | sed "s$tab^$tab$file$a$tab"
done | while IFS=$a read -r file link; do
    tmp=$(mktemp "$tmp_template")
    mv "$file" "$HOME/.cache/rss/read"
    curl "$link" > "$tmp" || {
        rm "$tmp"
        continue
    }
    case $(file -b --mime-type "$tmp") in
        image/*) ;;
        *) rm "$tmp" ;;
    esac
done

find "$download_dir" -maxdepth 1 -type f |
    xargs -d'\n' identify -format "%w %d/%f\n" | awk '$1 < 2560' |
    cut -d' ' -f2- | xargs -d'\n' rm

