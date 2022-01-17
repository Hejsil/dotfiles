#!/bin/sh

export LC_ALL=C
DEFAULT_OUTPUT=$(pactl info | sed -n -e 's/^.*Default Sink: //p')
if ! pactl info | grep -w "PipeWire" >/dev/null; then
    pactl unload-module module-default-device-restore
fi
pactl load-module module-null-sink sink_name=chromium
pactl load-module module-null-sink sink_name=desktop_audio
pactl set-default-sink desktop_audio
pactl load-module module-loopback source=desktop_audio.monitor "sink=$DEFAULT_OUTPUT"
pactl load-module module-loopback source=chromium.monitor "sink=$DEFAULT_OUTPUT"
if pactl info | grep -w "PipeWire" >/dev/null; then
    nohup pw-loopback --capture-props='node.target=desktop_audio' --playback-props='media.class=Audio/Source node.name=virtmic node.description="virtmic"' >/dev/null &
else
    pactl load-module module-remap-source master=desktop_audio.monitor source_name=virtmic source_properties=device.description=virtmic
fi
