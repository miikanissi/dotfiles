#!/bin/bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# hotplug dual monitor setup

pgrep bspwm > /dev/null || exit 0

monitor_add() {
  xrandr --output HDMI-1 \
    --mode 1920x1080 \
    --pos 0x0 \
    --rotate normal \
    --primary \
    --output eDP-1 \
    --mode 1920x1080 \
    --pos 1920x0 \
    --rotate normal

  n_d=5 # how many desktops on second monitor

  for desktop in $(bcpc query -D -m eDP-1 | sed "$n_d"q); do
    bspc desktop $desktop --to-monitor HDMI-1
  done

  bspc desktop Desktop --remove > /dev/null
}

monitor_remove() {
  if [[ "$(bspc query -M | wc -l)" = 1 ]]; then
    exit
  fi

  bspc monitor eDP-1 -a Desktop > /dev/null

  for desktop in $(bspc query -D -m eDP-1); do
    bspc desktop $desktop --to-monitor HDMI-1
  done

  # swap desktops
  bspc monitor HDMI-1 -a Desktop > /dev/null

  for desktop in $(bspc query -D -m HDMI-1); do
    bspc desktop $desktop --to-monitor eDP-1
  done

  bspc monitor HDMI-1 --remove > /dev/null

  xrandr --output HDMI-1 --off \
    --output eDP-1 \
    --primary \
    --mode 1920x1080 \
    --pos 0x0 \
    --rotate normal

  bspc desktop Desktop -r
}

if [[ $(hostname) == "arch-pc" ]]; then
  xrandr --output DVI-D-1 --mode 1920x1080 --rate 144 --primary
elif [[ $(hostname) == "TA-NISMI-E490" ]]; then
  if xrandr | grep -o "HDMI-1 connected" > /dev/null && [[ "$1" != "1" ]] && [[ "$(bspc query -M | wc -l)" != 2 ]]; then
    monitor_add
  else
    monitor_remove
  fi
fi
