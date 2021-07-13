#!/bin/sh -e

cd "$(dirname "$0")" || exit 1

install/linkup.sh
install/system-files.sh
install/programs.sh
install/generate-themes.sh
