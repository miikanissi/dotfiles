#!/bin/sh

sleep 2

# Lock file to prevent concurrent runs
lock="/tmp/keyboard.lock"
exec 9>"$lock"
if ! flock -n 9; then
    exit 1
fi

# Disable touchpad 
swaymsg input type:touchpad events disabled

# Set pointer acceleration and profile for all pointers
for id in $(swaymsg -t get_inputs | jq -r '.[] | select(.type=="pointer") | .identifier'); do
    swaymsg input "$id" accel_profile flat
    swaymsg input "$id" pointer_accel 0.7
done

