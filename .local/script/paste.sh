#!/bin/sh
cat "$@" | curl -F 'clbin=<-' https://clbin.com
