#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 2; done

outputs=$(xrandr --listactivemonitors|awk '{print $4}'|sed '/^$/d')
hostname=$(hostname)

for m in $outputs; do
  export MONITOR=$m
  if [[ "$hostname" == "TA-NISMI-E490" ]]; then
    MONITOR=$m polybar e490 -c ~/.config/polybar/minimal.ini &
  else
    MONITOR=$m polybar t440p -c ~/.config/polybar/minimal.ini &
  fi
done
