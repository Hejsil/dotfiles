#!/bin/sh

FILE=$1
FILEA=$2
FILEB=$3

if [ -z "$FILE" ] || [ -z "$FILEA" ] || [ -z "$FILEB" ]; then
    echo 'Expected 3 arguements' >&2
    exit 1
fi

if [ "$FILE" = "$FILEA" ] || [ "$FILE" = "$FILEB" ] || [ "$FILEA" = "$FILEB" ]; then
    echo 'Files cannot have same name' >&2
    exit 1
fi

CURRENT_BRANCH=$(git status | grep 'On branch' | cut -d ' ' -f 3-)
TMP_BRANCH='__tmp_branch__'

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
