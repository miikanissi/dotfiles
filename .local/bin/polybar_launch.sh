#!/usr/bin/env bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# launches polybar
(
  flock 200
  killall -q polybar
  while pgrep -u $UID -x polybar > /dev/null; do sleep 2; done

  PRIMARY_MONITOR=$(xrandr | grep primary | cut -d ' ' -f 1)
  MONITORS=$(xrandr --listactivemonitors|awk '{print $4}'|sed '/^$/d')
  HOSTNAME=$(hostname)
  TRAY=eDP-1

  if [[ "$HOSTNAME" == "stinkpad" ]]; then
    for m in $MONITORS; do
      if [[ $m == $PRIMARY_MONITOR ]]; then
        TRAY=$m
      fi
    done
    for m in $MONITORS; do
      if [[ $m == $PRIMARY_MONITOR ]]; then
        MONITOR1=$m polybar --reload main -c ~/.config/polybar/t440p_minimal.ini </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
        export TRAY_POSITION=right
      else
        MONITOR2=$m polybar --reload secondary -c ~/.config/polybar/t440p_minimal.ini </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
        export TRAY_POSITION=none
      fi
      disown
    done
  elif [[ "$HOSTNAME" == "TA-NISMI-E490" ]]; then
    for m in $MONITORS; do
      if [[ $m == $PRIMARY_MONITOR ]]; then
        TRAY=$m
      fi
    done
    for m in $MONITORS; do
      if [[ $m == $PRIMARY_MONITOR ]]; then
        MONITOR1=$m polybar --reload main -c ~/.config/polybar/e490_minimal.ini </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
        export TRAY_POSITION=right
      else
        MONITOR2=$m polybar --reload secondary -c ~/.config/polybar/e490_minimal.ini </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
        export TRAY_POSITION=none
      fi
      disown
    done
  fi
) 200>/var/tmp/polybar-launch.lock
