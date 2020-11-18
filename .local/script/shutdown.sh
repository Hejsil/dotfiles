#!/bin/sh -e
update.sh

running_kernel=$(uname -r)
disk_kernel=$(file -b /boot/vmlinuz-linux | sed 's/.*version //; s/ .*//')
if [ "$running_kernel" = "$disk_kernel" ]; then
    systemctl suspend
else
    systemctl poweroff
fi

