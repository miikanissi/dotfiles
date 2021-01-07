#!/bin/sh
#
# Script to check when weather_report was last updated

weather_report="${XDG_DATA_HOME:-$HOME/.local/share}/weather_report"

notify-send "Weather last updated: " "$(stat -c %y "$weather_report" 2>/dev/null | cut -b'1-16')"
