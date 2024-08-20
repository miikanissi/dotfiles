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
	if ! battery_info=$(acpi -b); then
		echo "Failed to get battery information."
		sleep 300
		continue
	fi

    battery_level=$(echo "$battery_info" | grep 'Battery 0' | grep -P -o '[0-9]+(?=%)')

	if ! [[ "$battery_level" =~ ^[0-9]+$ ]]; then
		echo "Invalid battery level: $battery_level"
		sleep 300
		continue
	fi

    charging_status=$(echo "$battery_info" | grep 'Battery 0' | grep -o "Charging")

	if [ "${battery_level}" -le 20 ] && [ -z "${charging_status}" ]; then
		notify-send "Low Battery" "Battery level is at ${battery_level}%" -u critical
	fi

	sleep 300
done
