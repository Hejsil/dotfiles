#!/bin/sh -e

cd "$(dirname "$0")/.."
local/script/generate xresources
local/script/generate dunstrc
local/script/generate gtk_theme