#!/usr/bin/env bash

disconnected=""
wireless_connected=""
ethernet_connected=""

ID="$(ip link | awk '/state UP/ {print $2}')"

case $BUTTON in
	1) $TERMINAL -e nmtui; pkill -RTMIN+4 dwmblocks ;;
esac

if [[ $ID == e* ]]; then
  echo "$ethernet_connected"
elif [[ $ID == w* ]]; then
  echo "$wireless_connected"
else
  echo "$disconnected"
fi
