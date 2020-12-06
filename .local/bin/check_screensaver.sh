#!/bin/sh
# checks if screensaver timeout is 0 or on

timeout=$(xset q | grep timeout | awk '{print $2}')

if [ "$timeout" = "0" ]; then
  echo ""
else
  echo ""
fi
