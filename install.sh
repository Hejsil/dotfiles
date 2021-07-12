#!/bin/sh -e

cd "$(dirname "$0")" || exit 1

install/programs.sh
install/system-files.sh
install/linkup.sh
install/generate-themes.sh
