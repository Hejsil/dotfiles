#!/bin/sh -e

cd "$(dirname "$0")/.."
local/script/generate dunstrc
local/script/generate xresources
