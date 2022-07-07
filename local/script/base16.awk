#!/bin/nawk -f

{
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
}
