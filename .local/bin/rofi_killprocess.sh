#!/bin/sh
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# pipes list of processes into rofi/dmenu and kills the selection

proc=$(ps -u "$USER" -o pid,%mem,%cpu,comm | sort -b -k2 -r | sed -n '1!p' | rofi -dmenu -i -p "Kill" | awk '{print $1,$4}')

[ -z "$proc" ] || (kill -15 "$(echo "$proc" | awk '{print $1}')" 2>/dev/null && notify-send "$(echo "$proc" | awk '{print $2}') killed")
