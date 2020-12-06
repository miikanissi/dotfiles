#!/bin/sh
# checks if dunst notifications are on/off

state=$(dunstctl is-paused)

if [ "$state" = "true" ]; then
  echo ""
else
  echo ""
fi
