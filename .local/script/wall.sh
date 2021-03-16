#!/bin/sh -e

while [ -n "$1" ]; do
    case $1 in
        --)
            shift
            break
            ;;
        -m | --monitor)
            shift
            monitors=$1
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        -*)
            usage
            exit 1
            ;;
        *) break ;;
    esac
    shift
done

folder=$1
[ -z "$folder" ] && {
    echo 'No folder provided' >&2
    exit 1
}
[ -z "$monitors" ] && monitors=$(xrandr | grep -c ' connected')
[ -z "$monitors" ] && {
    echo 'No amount of monitors specified' >&2
    exit 1
}

find "$folder" -type f | sort -R | head -n "$monitors" | sed 's/^/-z\n/' | xargs -d '\n' setroot
