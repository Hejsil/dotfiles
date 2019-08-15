#!/bin/sh

B="$1"; [ -z "$B" ] && echo "No input" && exit 1

[ "$B" -lt 1024 ] && echo "${B}B" && exit 0
KB="$(((B + 512) / 1024))"

[ "$KB" -lt 1024 ] && echo "${KB}KiB" && exit 0
MB="$(((KB + 512) / 1024))"

[ "$MB" -lt 1024 ] && echo "${MB}MiB" && exit 0
GB="$(((MB + 512) / 1024))"

[ "$GB" -lt 1024 ] && echo "${GB}GiB" && exit 0
echo "$(((GB + 512) / 1024))TiB"
