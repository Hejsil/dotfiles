#!/bin/sh -e

cd "$(dirname "$0")" || exit 1

sudo install/systemd-services.sh
sudo install/paru.sh
install/linkup.sh
install/generate-themes.sh
