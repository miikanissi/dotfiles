#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

outputs=$(xrandr --listactivemonitors|awk '{print $4}'|sed '/^$/d')

for m in $outputs; do
  export MONITOR=$m
  if [[ "$(hostname)" == "TA-NISMI-E490" ]]; then
    MONITOR=$m polybar --reload bar-e490 -c ~/.config/polybar/config &
  else
    MONITOR=$m polybar --reload bar-t440p -c ~/.config/polybar/config &
  fi
done
