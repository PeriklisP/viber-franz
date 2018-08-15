#!/bin/bash
# Viber needs a soundcard for audio output...
export HOME="/home/user"
export PULSE_LATENCY_MSEC=60
export PULSE_SERVER="tcp:localhost:64713"
export TZ=`tzupdate -p` # Set timezone based on location...

bash -c 'while : ; do sleep 1 && wmctrl -r Viber -b add,fullscreen ; done' &
/opt/viber/Viber

# http://localhost:9981/?password=viber-franz&autoconnect=true&reconnect=true&resize=remote&reconnect_delay=1000