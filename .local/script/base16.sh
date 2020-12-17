#!/bin/sh

scheme=$1
template=$2

if [ -z "$scheme" ]; then
    echo 'No scheme' >&2
    exit 1
fi

# If no template was given, read it from stdin
if [ -z "$template" ]; then
    template_CONTENT=$(cat)
    template=$(mktemp "/tmp/template.XXXXXX")
    echo "$template_CONTENT" >"$template"
fi

<"$scheme" sed -e '/^#/d' -e 's/^COLOR//' | awk --non-decimal-data -F'=' '{
    R = substr($2, 1, 2)
    G = substr($2, 3, 2)
    B = substr($2, 5, 2)
    printf " -e s/{{base0%X-hex}}/%s/g", $1, $2
    printf " -e s/{{base0%X-hex-r}}/%s/g", $1, R
    printf " -e s/{{base0%X-hex-g}}/%s/g", $1, G
    printf " -e s/{{base0%X-hex-b}}/%s/g", $1, B
    printf " -e s/{{base0%X-hex-bgr}}/%s%s%s/g", $1, B, G, R
    printf " -e s/{{base0%X-rgb-r}}/%d/g", $1, "0x" R
    printf " -e s/{{base0%X-rgb-g}}/%d/g", $1, "0x" G
    printf " -e s/{{base0%X-rgb-b}}/%d/g", $1, "0x" B
}' | xargs sed "$template"
