#!/bin/bash

lock_file="/tmp/bspwm_floating.lock"

if [ -e "$lock_file" ]; then
    # If the lock file exists, check if the PID in the lock file is still running
    old_pid=$(cat "$lock_file")
    if ps -p "$old_pid" > /dev/null; then
        echo "BSPWM floating script is already running."
        exit 1
    else
        notify-send "Not running"
        # If the PID is not running, remove the lock file
        rm -f "$lock_file"
    fi
fi

# Write the current PID to the lock file
echo "$$" > "$lock_file"

trap 'rm -f "$lock_file"' EXIT

bspc subscribe node_add | while read -ra msg; do
    float_desk_id=$(bspc query -D -d '^3')
    desk_id=${msg[2]}
    wid=${msg[4]}
    [ "$float_desk_id" = "$desk_id" ] && bspc node "$wid" -t floating
done

