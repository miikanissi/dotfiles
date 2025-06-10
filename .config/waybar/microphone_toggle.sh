#!/bin/bash
# by Miika Nissi https://miikanissi.com
# toggles microphone mute and echoes JSON for waybar
# requires amixer

for arg in "$@"; do
    if [ "$arg" == "--on" ]; then
        amixer -q set Capture cap
    elif [ "$arg" == "--off" ]; then
        amixer -q set Capture nocap
    elif [ "$arg" == "--toggle" ]; then
        on=$(amixer get Capture | grep "\[on\]")
        if [ -z "$on" ]; then
            amixer -q set Capture cap
        else
            amixer -q set Capture nocap
        fi
    fi
done

# Output JSON for waybar
on=$(amixer get Capture | grep "\[on\]")
if [ -z "$on" ]; then
    # muted
    echo '{"alt":"muted", "class":"muted", "tooltip": "microphone: muted"}'
else
    # unmuted
    echo '{"alt":"on", "class":"on", "tooltip": "microphone: on"}'
fi
