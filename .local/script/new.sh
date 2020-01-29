#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
    exit "$1"
}

while getopts "h" OPT; do
    case "$OPT" in
        h) usage 0 ;;
        *) usage 1 ;;
    esac
done
shift $((OPTIND-1))

FILENAME="$1"
[ -e "$FILENAME" ] && echo "$FILENAME already exists" && exit 1

EXT="${FILENAME##*.}"
case "$EXT" in
    "sh")
        {
            echo '#!/bin/sh'
            echo ''
            echo 'PROGRAM="$(basename "$0")"'
            echo 'usage() {'
            echo '    echo "Usage: $(basename "$PROGRAM")"'
            echo '    exit "$1"'
            echo '}'
            echo ''
            echo 'while getopts "h" OPT; do'
            echo '    case "$OPT" in'
            echo '        h) usage 0 ;;'
            echo '        *) usage 1 ;;'
            echo '    esac'
            echo 'done'
            echo 'shift $((OPTIND-1))'
            echo ''
            echo "echo 'Hello World!'"
        } > "$FILENAME"
        chmod +x "$FILENAME"
        ;;
    "html")
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
    "md")
        {
            echo '# Hello World'
            echo 'Hello World!'
        } > "$FILENAME"
        ;;
    "zig")
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
