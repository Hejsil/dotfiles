#!/bin/sh
rr record -n $@
rr replay
