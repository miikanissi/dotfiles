#!/bin/bash

lock_file="/tmp/low_battery_notification.lock"

if [ -e "$lock_file" ]; then
	echo "Script is already running."
	exit 1
fi

touch "$lock_file"

trap 'rm -f "$lock_file"' EXIT

while true; do
	battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	charging_status=$(acpi -b | grep -o "Charging")

	if [ "$battery_level" -le 20 ] && [ -z "$charging_status" ]; then
		notify-send "Low Battery" "Battery level is at ${battery_level}%" -u critical
	fi

	sleep 300
done
