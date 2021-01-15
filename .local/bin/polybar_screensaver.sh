#!/bin/bash
# by Miika Nissi https://miikanissi.com
# toggles screensaver and echoes corresponding emoji for polybar

for arg in "$1"
do
  if [ "$arg" == "--on" ]; then
    xset s on -dpms
    echo ""
  elif [ "$arg" == "--off" ]; then
    xset s off -dpms
    echo ""
  elif [ "$arg" == "--toggle" ]; then
    timeout=$(xset q | grep timeout | awk '{print $2}')
    if [ "$timeout" = "0" ]; then
      xset s on -dpms
      echo ""
    else
      xset s off -dpms
      echo ""
    fi
  else
    printf "Usage: polybar_screensaver.sh [OPTION]\nOptions:\n--on      Turn screensaver on\n--off     Turn screensaver off\n--toggle  Toggles screensaver on/off\n"
  fi
done
