#!/bin/sh -e
paru -Syu --noconfirm
paru -Sc --noconfirm
paru -c --noconfirm
exec duperemove --hashfile "$HOME/.cache/duperemove.hash" -dhr "$HOME"
