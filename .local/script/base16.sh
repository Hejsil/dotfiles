#!/bin/sh

SCHEME="$1"; [ -z "$SCHEME" ] && echo "No scheme" && exit 1
TEMPLATE="$2"; [ -z "$TEMPLATE" ] && {
    TEMPLATE_CONTENT="$(cat)"
    TEMPLATE="$(mktemp "/tmp/template.XXXXXX")"
    echo "$TEMPLATE_CONTENT" >"$TEMPLATE"
}

eval "$(cat "$SCHEME")"

seq 0 15 | while read -r NUM; do
    (
    COLORVAR="\$COLOR$NUM"
    HEX="$(eval "echo \"$COLORVAR\"")"
    echo "$HEX" | fold -w2 | paste -sd ' ' - | (
    read -r HEX_R HEX_G HEX_B

    printf "%d %d %d" "0x$HEX_R" "0x$HEX_G" "0x$HEX_B" | (
    read -r RGB_R RGB_G RGB_B

    (
        echo "$RGB_R / 255"
        echo "$RGB_G / 255"
        echo "$RGB_B / 255"
    ) | bc -l | paste -sd ' ' - | (
    read -r DEC_R DEC_G DEC_B
    
    printf " -e s/{{base0%X-hex}}/%s/g 
 -e s/{{base0%X-hex-r}}/%s/g
 -e s/{{base0%X-hex-g}}/%s/g
 -e s/{{base0%X-hex-b}}/%s/g
 -e s/{{base0%X-hex-bgr}}/%s/g
 -e s/{{base0%X-rgb-r}}/%s/g
 -e s/{{base0%X-rgb-g}}/%s/g
 -e s/{{base0%X-rgb-b}}/%s/g
 -e s/{{base0%X-dec-r}}/0%s/g
 -e s/{{base0%X-dec-g}}/0%s/g
 -e s/{{base0%X-dec-b}}/0%s/g" \
    "$NUM" "$HEX" \
    "$NUM" "$HEX_R" \
    "$NUM" "$HEX_G" \
    "$NUM" "$HEX_B" \
    "$NUM" "${HEX_B}${HEX_G}${HEX_R}" \
    "$NUM" "$RGB_R" \
    "$NUM" "$RGB_G" \
    "$NUM" "$RGB_B" \
    "$NUM" "$DEC_R" \
    "$NUM" "$DEC_G" \
    "$NUM" "$DEC_B"
    ) ) ) ) &
done | xargs sed "$TEMPLATE"
