#!/bin/sh

SCHEME="$1"; [ -z "$SCHEME" ] && echo "No scheme" && exit 1
TEMPLATE="$2"; [ -z "$TEMPLATE" ] && {
    TEMPLATE_CONTENT="$(cat)"
    TEMPLATE="$(mktemp "/tmp/template.XXXXXX")"
    echo "$TEMPLATE_CONTENT" >"$TEMPLATE"
}

eval "$(cat "$SCHEME")"

seq 0 15 | while read -r NUM; do
    BASE="$(printf "base0%X" "$NUM")"
    COLORVAR="\$COLOR$NUM"
    HEX="$(eval "echo \"$COLORVAR\"")"
    HEX_R="$(echo "$HEX" | cut -c1-2)"
    HEX_G="$(echo "$HEX" | cut -c3-4)"
    HEX_B="$(echo "$HEX" | cut -c5-6)"
    HEX_BGR="${HEX_B}${HEX_G}${HEX_R}"
    RGB_R="$(printf %d "0x$HEX_R")"
    RGB_G="$(printf %d "0x$HEX_G")"
    RGB_B="$(printf %d "0x$HEX_B")"
    DEC_R="0$(echo "$RGB_R / 255" | bc -l)"
    DEC_G="0$(echo "$RGB_G / 255" | bc -l)"
    DEC_B="0$(echo "$RGB_B / 255" | bc -l)"
    printf "%s" " -e s/{{$BASE-hex}}/$HEX/g"
    printf "%s" " -e s/{{$BASE-hex-r}}/$HEX_R/g"
    printf "%s" " -e s/{{$BASE-hex-g}}/$HEX_G/g"
    printf "%s" " -e s/{{$BASE-hex-b}}/$HEX_B/g"
    printf "%s" " -e s/{{$BASE-hex-bgr}}/$HEX_BGR/g"
    printf "%s" " -e s/{{$BASE-rgb-r}}/$RGB_R/g"
    printf "%s" " -e s/{{$BASE-rgb-g}}/$RGB_G/g"
    printf "%s" " -e s/{{$BASE-rgb-b}}/$RGB_B/g"
    printf "%s" " -e s/{{$BASE-dec-r}}/$DEC_R/g"
    printf "%s" " -e s/{{$BASE-dec-g}}/$DEC_G/g"
    printf "%s" " -e s/{{$BASE-dec-b}}/$DEC_B/g"
done | xargs sed "$TEMPLATE"
