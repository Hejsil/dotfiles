#!/bin/sh

SCHEME=$1
TEMPLATE=$2

if [ -z "$SCHEME" ]; then
    echo 'No scheme' >&2
    exit 1
fi

# If no template was given, read it from stdin
if [ -z "$TEMPLATE" ]; then
    TEMPLATE_CONTENT=$(cat)
    TEMPLATE=$(mktemp "/tmp/template.XXXXXX")
    echo "$TEMPLATE_CONTENT" >"$TEMPLATE"
fi

eval "$(cat )"

# Very ugly, but fast way to generate sed arguments that replace
# the template replacements with colors from the scheme.
# Find a prettier way that is just as fast.
<"$SCHEME" sed -e '/^#/d' -e 's/^COLOR//' | awk --non-decimal-data -F'=' '{
    R = substr($2, 0, 2)
    G = substr($2, 2, 2)
    B = substr($2, 4, 2)
    printf " -e s/{{base0%X-hex}}/%s/g", $1, $2
    printf " -e s/{{base0%X-hex-r}}/%s/g", $1, R
    printf " -e s/{{base0%X-hex-g}}/%s/g", $1, G
    printf " -e s/{{base0%X-hex-b}}/%s/g", $1, B
    printf " -e s/{{base0%X-hex-bgr}}/%s%s%s/g", $1, G, B, R
    printf " -e s/{{base0%X-rgb-r}}/%d/g", $1, "0x" R
    printf " -e s/{{base0%X-rgb-g}}/%d/g", $1, "0x" G
    printf " -e s/{{base0%X-rgb-b}}/%d/g", $1, "0x" B
}' | xargs sed "$TEMPLATE"
