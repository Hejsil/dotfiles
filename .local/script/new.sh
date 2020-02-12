#!/bin/sh

PROGRAM=${0##*/}
usage() {
    echo "Usage: $PROGRAM"
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

FILENAME=$1
if [ -e "$FILENAME" ]; then
    echo "$FILENAME already exists"
    exit 1
fi

EXT="${FILENAME##*.}"
case $EXT in
    sh)
        {
            echo '#!/bin/sh'
            echo ''
            echo 'PROGRAM="${0##*/}"'
            echo 'usage() {'
            echo '    echo "Usage: "'
            echo '}'
            echo ''
            echo 'while [ -n "$1" ]; do'
            echo '    case $1 in'
            echo '        --) shift; break ;;'
            echo '        -h|--help) usage; exit 0 ;;'
            echo '        -*) usage; exit 1 ;;'
            echo '        *) break ;;'
            echo '    esac'
            echo '    shift'
            echo 'done'
            echo ''
            echo "echo 'Hello World!'"
        } > "$FILENAME"
        chmod +x "$FILENAME"
        ;;
    html)
        {
            echo '<!DOCTYPE html>'
            echo '<html>'
            echo ''
            echo '<head>'
            echo '    <title>Hello World</title>'
            echo '</head>'
            echo ''
            echo '<body>'
            echo '    <p>Hello World!</p>'
            echo '</body>'
            echo ''
            echo '</html>'
        } > "$FILENAME"
        ;;
    md)
        {
            echo '# Hello World'
            echo 'Hello World!'
        } > "$FILENAME"
        ;;
    zig)
        {
            echo 'const std = @import("std");'
            echo ''
            echo 'pub fn main() void {'
            echo '    std.debug.warn("Hello World!");'
            echo '}'
        } > "$FILENAME"
        ;;
    *)
        touch "$FILENAME"
        ;;
esac
