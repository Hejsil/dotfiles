#!/bin/sh -e

cd "$(dirname "$0")/.."

source config/env

local/script/generate dunstrc
local/script/generate foot
