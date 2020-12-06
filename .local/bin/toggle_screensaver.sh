#!/bin/sh
# toggles screensaver on/off

timeout=$(xset q | grep timeout | awk '{print $2}')

if [ "$timeout" = "0" ]; then
  xset s on -dpms
else
  xset s off -dpms
fi
