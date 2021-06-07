#!/usr/bin/env bash

# Loop through all attached batteries and format the info
for battery in /sys/class/power_supply/BAT?*; do
  # If non-first battery, print a space separator.
	[ -n "${capacity+x}" ] && printf " "
  # setup icon and capacity
  capacity=$(cat "$battery/capacity")
  if [[ $capacity -gt 90 ]]; then
    icon=
  elif [[ $capacity -gt 60 ]]; then
    icon=
  elif [[ $capacity -gt 30 ]]; then
    icon=
  else
    icon=
    warn=" LOW BATTERY"
  fi
  printf "%s   %s%%%s" "$icon" "$capacity" "$warn"; unset warn
done
