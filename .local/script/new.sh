#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
}

while getopts "h" OPT; do
    case "$OPT" in
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

FILENAME="$1"
EXT="${FILENAME##*.}"
[ -e "$FILENAME" ] && echo "$FILENAME already exists" && exit 1

case "$EXT" in
    "sh")
        {
            echo '#!/bin/sh'
            echo ''
            echo 'PROGRAM="$(basename "$0")"'
            echo 'usage() {'
            echo '    echo "Usage: $(basename "$PROGRAM")"'
            echo '}'
            echo ''
            echo 'while getopts "h" OPT; do'
            echo '    case "$OPT" in'
            echo '        h)'
            echo '            usage'
            echo '            exit 0'
            echo '            ;;'
            echo '        *)'
            echo '            usage'
            echo '            exit 1'
            echo '            ;;'
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
            echo '    std.debug.warn("Hello World!")'
            echo '}'
        } > "$FILENAME"
        ;;
    *)
        touch "$FILENAME"
        ;;
esac
