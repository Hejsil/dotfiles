#!/bin/sh
function cloneAll() {
    (
        cd "$HOME/repo"
        curl "https://api.github.com/users/$1/repos" | jq '.[].ssh_url' | xargs -L1 git clone --recursive
    )
}

cloneAll Hejsil
cloneAll ziglang

(
    cd "$HOME/repo/zig"
    mkdir -p build/stage1
    mkdir -p build/stage2

    cd build/stage1
    cmake ../../
    make -j $(($(cat /proc/stat | grep 'cpu[0-9]' | tail -n 1 | sed -E 's/cpu([0-9]*).*/\1/') + 2))
    make install
    ln -sf $(pwd)/bin/zig ~/.bin/zig1

    cd ../..
    zig1 build --prefix $(pwd)/build/stage2 install
    ln -sf $(pwd)/build/stage2/bin/zig ~/.bin/zig2
)

(
    cd "$HOME/repo/sab"
    sudo zig1 build -Drelease-safe=true install
)
