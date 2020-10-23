#!/bin/sh

file=$1
filea=$2
fileb=$3

if [ -z "$file" ] || [ -z "$filea" ] || [ -z "$fileb" ]; then
    echo 'Expected 3 arguements' >&2
    exit 1
fi

if [ "$file" = "$filea" ] || [ "$file" = "$fileb" ] || [ "$filea" = "$fileb" ]; then
    echo 'files cannot have same name' >&2
    exit 1
fi

current_branch=$(git status | grep 'On branch' | cut -d ' ' -f 3-)
tmp_branch='__tmp_branch__'

git checkout -b "$tmp_branch"
git mv "$file" "$filea"
git commit --no-verify -m "git mv '$file' '$filea'"

git checkout "$current_branch"
git mv "$file" "$fileb"
git commit --no-verify -m "git mv '$file' '$fileb'"

git merge --no-ff "$tmp_branch"
git rm "$file"
git add "$filea"
git add "$fileb"
git commit --no-verify

git branch -d "$tmp_branch"
