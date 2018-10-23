#!/bin/sh
function cloneAll() {
    (
        cd "$HOME/repo"
        curl "https://api.github.com/users/$1/repos" | jq '.[].ssh_url' | xargs -L1 git clone --recursive
    )
}

cloneAll Hejsil
cloneAll ziglang
