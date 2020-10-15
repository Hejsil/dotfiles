#!/bin/sh
[ -z "$1" ] && { echo "Expected name"; exit 1; }
[ -z "$2" ] && { echo "Expected email"; exit 1; }

git config --local user.name "$1"
git config --local user.email "$2"
