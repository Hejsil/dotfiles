#!/bin/sh -e

cd "$(dirname "$0")/.."
cp -ri "systemd/getty@tty1.service.d" "/etc/systemd/system/"
