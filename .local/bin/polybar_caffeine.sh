#!/bin/bash
# by Miika Nissi https://miikanissi.com
# toggles screensaver and echoes corresponding emoji for polybar

for arg in $1
do
  if [ "$arg" == "--on" ]; then
    xset s off s noblank -dpms
    echo ""
  elif [ "$arg" == "--off" ]; then
    xset s on s blank -dpms
    echo "鈴"
  elif [ "$arg" == "--toggle" ]; then
    timeout=$(xset q | grep timeout | awk '{print $2}')
    if [ "$timeout" = "0" ]; then
      xset s on s blank -dpms
      echo "鈴"
    else
      xset s off s noblank -dpms
      echo ""
    fi
  else
    printf "Usage: polybar_screensaver.sh [OPTION]\nOptions:\n--on      Turn caffeine mode on\n--off     Turn caffeine mode off\n--toggle  Toggles caffeine mode on/off\n"
  fi
done
