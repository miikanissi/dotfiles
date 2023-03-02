#!/usr/bin/env sh

if [ "$1" = period-changed ]; then
	case $3 in
	daytime)
		toggle-theme.sh -l
		;;
	transition)
		if [ "$2" = none ]; then
			toggle-theme.sh -l
		fi
		;;
	night)
		toggle-theme.sh -d
		;;
	esac
fi
