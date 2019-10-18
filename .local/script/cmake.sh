#!/bin/sh
[ -e build ] || (
    mkdir build
    cd build || exit 1
    cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
)

make -C build "-j$(nproc)" "$@"
