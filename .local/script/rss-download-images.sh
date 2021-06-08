#!/bin/sh

rss.sh

download_dir="$HOME/downloads/images"
mkdir -p "$download_dir"
tmp_template="$download_dir/XXXXXX"

tab=$(printf '\t')
a=$(printf '\a')
rss-list.sh -u | tr "$tab" "$a" | while IFS=$a read -r file _ _ link desc _; do
    case $link in
        *konachan.net*)
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
        *www.reddit.com* | *pixiv.net*)
            echo "$desc" | grep -oE '\w+:\/\/[-a-zA-Z0-9:@;?&=\/%\+\.\*!'"'"'\(\),\$_\{\}\^~`#|]+'
            ;;
    esac | sed "s$tab^$tab$file$a$tab"
done | while IFS=$a read -r file link; do
    tmp=$(mktemp "$tmp_template")
    curl "$link" >"$tmp" || {
        rm "$tmp"
        continue
    }

    mv "$file" "$HOME/.local/share/rss/read/"
    case $(file -b --mime-type "$tmp") in
        image/*) ;;
        *) rm "$tmp" ;;
    esac
done
