#!/usr/bin/env -S sh
exe=$1
shift

gdb -nh -x "$XDG_CONFIG_HOME/gdb/init" "$exe" -ex "run $*"
