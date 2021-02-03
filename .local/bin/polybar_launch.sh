#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

outputs=$(xrandr --listactivemonitors|awk '{print $4}'|sed '/^$/d')

for m in $outputs; do
  export MONITOR=$m
  MONITOR=$m polybar --reload bar-t440p -c ~/.config/polybar/config &
done
