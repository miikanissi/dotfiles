#!/bin/bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# hotplug dual monitor setup

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
pgrep bspwm > /dev/null || exit 0

for desktop in $(bspc query -D --names); do
  if [[ $desktop == "Desktop" ]]; then
    bspc monitor -d 1 2 3 4 5 6 7 8
    bspc desktop Desktop --remove > /dev/null
    bspc desktop Desktop --remove > /dev/null
    break
  fi
done

monitor_add() {
  xrandr --output HDMI-1 \
    --mode 1920x1080 \
    --pos 0x0 \
    --rotate normal \
    --primary \
    --output eDP-1 \
    --mode 1920x1080 \
    --pos -1920x0 \
    --rotate normal

  bspc monitor eDP-1 -a Desktop > /dev/null

  for desktop in $(bspc query -D -m eDP-1 | sed "8"q); do
    bspc desktop $desktop --to-monitor HDMI-1
  done

  bspc desktop Desktop --remove > /dev/null
  bspc desktop Desktop --remove > /dev/null

  for desktop in $(bspc query -D -m HDMI-1 | sed "5"q); do
    bspc desktop $desktop --to-monitor eDP-1
  done

  bspc desktop Desktop --remove > /dev/null
  bspc desktop Desktop --remove > /dev/null

  polybar main &
  polybar secondary &
}

monitor_remove() {
  if [[ "$(bspc query -M | wc -l)" = 1 ]]; then
    polybar main &
    exit
  fi
  bspc monitor HDMI-1 -a Desktop > /dev/null

  for desktop in $(bspc query -D -m HDMI-1 | sed "4"q); do
    bspc desktop $desktop --to-monitor eDP-1
  done

  bspc monitor HDMI-1 --remove > /dev/null

  xrandr --output HDMI-1 --off \
    --output eDP-1 \
    --primary \
    --mode 1920x1080 \
    --pos 0x0 \
    --rotate normal

  bspc desktop Desktop --remove > /dev/null

  polybar main &
}

if [[ $(hostname) == "arch-pc" ]]; then
  xrandr --output DVI-D-1 --mode 1920x1080 --rate 144 --primary
  bspc monitor -d 1 2 3 4 5 6 7 8
  bspc desktop Desktop --remove > /dev/null
  polybar main &
elif [[ $(hostname) == "TA-NISMI-E490" ]]; then
  if xrandr | grep -o "HDMI-1 connected" > /dev/null && [[ "$1" != "1" ]] && [[ "$(bspc query -M | wc -l)" != 2 ]]; then
    monitor_add
  else
    monitor_remove
  fi
fi
