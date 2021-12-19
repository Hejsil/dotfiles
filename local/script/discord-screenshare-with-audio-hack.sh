#!/bin/sh

export LC_ALL=C
DEFAULT_OUTPUT=$(pactl info | sed -n -e 's/^.*Default Sink: //p')
pactl unload-module module-default-device-restore
pactl load-module module-null-sink sink_name=chromium
pactl load-module module-null-sink sink_name=desktop_audio
pactl set-default-sink desktop_audio
pactl load-module module-loopback source=desktop_audio.monitor "sink=$DEFAULT_OUTPUT"
pactl load-module module-loopback source=chromium.monitor "sink=$DEFAULT_OUTPUT"
pactl load-module module-remap-source master=desktop_audio.monitor source_name=virtmic source_properties=device.description=virtmic
pactl set-default-source virtmic
