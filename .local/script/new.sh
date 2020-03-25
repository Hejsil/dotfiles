#!/bin/sh

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

filename=$1
if [ -e "$filename" ]; then
    echo "$filename already exists"
    exit 1
fi

ext="${filename##*.}"
case $ext in
    sh)
        {
            echo '#!/bin/sh'
            echo ''
            echo 'program="${0##*/}"'
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
        } > "$filename"
        chmod +x "$filename"
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
        } > "$filename"
        ;;
    md)
        {
            echo '# Hello World'
            echo 'Hello World!'
        } > "$filename"
        ;;
    zig)
        {
            echo 'const std = @import("std");'
            echo ''
            echo 'pub fn main() void {'
            echo '    std.debug.warn("Hello World!");'
            echo '}'
        } > "$filename"
        ;;
    *)
        touch "$filename"
        ;;
esac
