#!/bin/sh
pactl list sinks | grep Sink | sed 's/Sink #//'
