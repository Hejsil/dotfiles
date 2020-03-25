#!/bin/sh
exe=$1
shift

gdb "$exe" -ex "run $*"
