#!/usr/bin/sh -e

file=$1
filea=$2
fileb=$3

if [ -z "$file" ] || [ -z "$filea" ] || [ -z "$fileb" ]; then
    echo 'Expected 3 arguements' >&2
    exit 1
fi

if [ "$filea" = "$fileb" ]; then
    echo 'files cannot have same name' >&2
    exit 1
fi

current_branch=$(git status | grep 'On branch' | cut -d ' ' -f 3-)
tmp_branch='__tmp_branch__'
tmp_file=$(mktemp -p .)
msg=$(printf "Splitting '%s' into '%s and '%s'" "$file" "$filea" "$fileb")

git mv -f "$file" "$tmp_file"
git commit --no-verify -m "$(printf "%s\n\ngit mv '%s' '%s'" "$msg" "$file" "$tmp_file")"

git checkout -b "$tmp_branch"
git mv "$tmp_file" "$filea"
git commit --no-verify -m "$(printf "%s\n\ngit mv '%s' '%s'" "$msg" "$tmp_file" "$filea")"

git checkout "$current_branch"
git mv "$tmp_file" "$fileb"
git commit --no-verify -m "$(printf "%s\n\ngit mv '%s' '%s'" "$msg" "$tmp_file" "$fileb")"

git merge --no-ff "$tmp_branch" || true
git rm "$tmp_file"
git add "$filea"
git add "$fileb"
git commit --no-verify -m "$(printf "%s\n\ngit merge '%s'" "$msg" "$tmp_branch")"

git branch -d "$tmp_branch"
