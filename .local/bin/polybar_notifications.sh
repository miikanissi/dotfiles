#!/bin/bash
# by Miika Nissi https://miikanissi.com
# toggles notifications and echoes corresponding emoji for polybar

for arg in $1; do
	if [ "$arg" == "--on" ]; then
		notify-send "DUNST_COMMAND_RESUME"
		echo ""
	elif [ "$arg" == "--off" ]; then
		notify-send "DUNST_COMMAND_PAUSE"
		echo ""
	elif [ "$arg" == "--toggle" ]; then
		state=$(dunstctl is-paused)
		if $state; then
			notify-send "DUNST_COMMAND_RESUME"
			echo ""
		else
			notify-send "DUNST_COMMAND_PAUSE"
			echo ""
		fi
	else
		printf "Usage: polybar_notifications.sh [OPTION]\nOptions:\n--on      Turn notifications on\n--off     Turn notifications off\n--toggle  Toggles notifications on/off\n"
	fi
done
