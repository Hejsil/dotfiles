#!/usr/bin/env -S sh

if ! [ -e build ]; then (
    mkdir build
    cd build || exit
    cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
) fi

make -C build "-j$(nproc)" "$@"
