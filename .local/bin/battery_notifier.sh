#!/bin/bash

lock_file="/tmp/low_battery_notification.lock"

if [ -e "$lock_file" ]; then
	echo "Battery notifier script is already running."
	exit 1
fi

if ! touch "$lock_file"; then
	echo "Failed to create lock file."
	exit 1
fi

trap 'rm -f "$lock_file"' EXIT

while true; do
	if ! battery_level=$(cat /sys/class/power_supply/BAT0/capacity); then
		echo "Failed to get battery level."
		sleep 300
		continue
	fi

	if ! [[ "$battery_level" =~ ^[0-9]+$ ]]; then
		echo "Invalid battery level: $battery_level"
		sleep 300
		continue
	fi
	
    if ! battery_status=$(cat /sys/class/power_supply/BAT0/status); then
		echo "Failed to get battery status."
		sleep 300
		continue
	fi

	if [ "${battery_level}" -le 20 ] && [ "${battery_status}" != "Charging" ]; then
		notify-send "Low Battery" "Battery level is at ${battery_level}%" -u critical
	fi

	sleep 300
done
