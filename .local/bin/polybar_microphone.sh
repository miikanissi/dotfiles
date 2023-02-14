#!/bin/bash
# by Miika Nissi https://miikanissi.com
# toggles microphone mute and echoes corresponding emoji for polybar
# requires amixer

color=$(xrdb -query | grep 'color1:' | awk '{print $NF}')
for arg in $1; do
	if [ "$arg" == "--on" ]; then
		amixer -q set Capture cap
		echo ""
	elif [ "$arg" == "--off" ]; then
		amixer -q set Capture nocap
		echo "%{F$color}%{F-}"
	elif [ "$arg" == "--toggle" ]; then
		on=$(amixer get Capture | grep "\[on\]")
		if [ -z "$on" ]; then
			amixer -q set Capture cap
			echo ""
		else
			amixer -q set Capture nocap
			echo "%{F$color}%{F-}"
		fi
	else
		printf "Usage: polybar_microphone.sh [OPTION]\nOptions:\n--on      Unmute microphone\n--off     Mute microphone\n--toggle  Toggles mute/unmute\n"
	fi
done
