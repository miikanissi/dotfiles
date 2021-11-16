#!/bin/bash

case $BUTTON in
  1) xset s off s noblank -dpms ;;
  3) xset s on s blank -dpms ;;
esac

for arg in $1
do
  if [ "$arg" == "--on" ]; then
    xset s on s blank -dpms
  elif [ "$arg" == "--off" ]; then
    xset s off s noblank -dpms
  elif [ "$arg" == "--toggle" ]; then
    timeout=$(xset q | grep timeout | awk '{print $2}')
    if [ "$timeout" = "0" ]; then
      xset s on s blank -dpms
    else
      xset s off s noblank -dpms
    fi
  else
    printf "Usage: polybar_screensaver.sh [OPTION]\nOptions:\n--on      Turn caffeine mode on\n--off     Turn caffeine mode off\n--toggle  Toggles caffeine mode on/off\n"
  fi
done

if [ "$(xset q | grep timeout | awk '{print $2}')" == "0" ]; then
  printf ""
else
  printf ""
fi
