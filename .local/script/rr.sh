#!/bin/sh
rr record "$@"
rr replay
