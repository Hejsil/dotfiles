#!/bin/sh
CACHE=~/.cache/hub/
REPO_CACHE="$CACHE/$(git remote get-url origin || exit 1)"
REPO_CACHE_DATE="$REPO_CACHE/date"
mkdir -p "$REPO_CACHE"

DATE="2019-02-16T13:16:38+01:00"
#DATE="$(cat "$REPO_CACHE_DATE" 2>/dev/null || echo "2000-01-01")"
#if [ -z "$DATE" ]; then
#    DATE="2000-01-01"
#fi

hub issue --since "$DATE" -f "%I%n" | while read ISSUE; do
    reset
    ghi show "$ISSUE"
    read LINE
done

date -Iseconds > "$REPO_CACHE_DATE"