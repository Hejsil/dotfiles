#!/bin/sh
[ -e build ] || (
    mkdir build
    cd build || exit 1
    cmake ..
)

make -C build "-j$(nproc)" "$@"
