#!/bin/sh

FILE="$1"; [ -z "$FILE" ] && { echo "No file provided"; exit 1; }
FILEA="$2"; [ -z "$FILEA" ] && { echo "Missing name for first new file"; exit 1; }
FILEB="$3"; [ -z "$FILEB" ] && { echo "Missing name for second new file"; exit 1; }
[ "$FILE" = "$FILEA" ] && { echo "Files cannot have same name"; exit 1; }
[ "$FILE" = "$FILEB" ] && { echo "Files cannot have same name"; exit 1; }
[ "$FILEA" = "$FILEB" ] && { echo "Files cannot have same name"; exit 1; }

CURRENT_BRANCH="$(git status | grep 'On branch' | cut -d ' ' -f 3-)"
TMP_BRANCH="__tmp_branch__"

git checkout -b "$TMP_BRANCH"
git mv "$FILE" "$FILEA"
git commit -m "git mv '$FILE' '$FILEA'"

git checkout "$CURRENT_BRANCH"
git mv "$FILE" "$FILEB"
git commit -m "git mv '$FILE' '$FILEB'"

git merge --no-ff "$TMP_BRANCH"
git rm "$FILE"
git add "$FILEA"
git add "$FILEB"
git commit

git branch -d "$TMP_BRANCH"
