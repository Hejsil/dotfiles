#!/bin/sh
EXE=$1
shift

gdb "$EXE" -ex "run $*"
