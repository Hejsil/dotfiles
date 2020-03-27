#!/bin/sh

program=$(which $1)
shift
daemonize "$program" "$@"