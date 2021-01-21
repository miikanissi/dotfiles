#!/bin/bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# hotplug dual monitor setup for bspwm & polybar
# usage: include script in .config/bspwm/bspwmrc, restart bspwm when monitor is added/removed

internal_monitor=eDP-1
external_monitor=HDMI-1

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
  xrandr --output $external_monitor \
    --mode 1920x1080 \
    --pos 0x0 \
    --rate 60 \
    --rotate normal \
    --primary \
    --output $internal_monitor \
    --mode 1920x1080 \
    --pos -1920x0 \
    --rate 60 \
    --rotate normal

  bspc monitor $internal_monitor -a Desktop > /dev/null

  for desktop in $(bspc query -D -m $internal_monitor | sed "8"q); do
    bspc desktop $desktop --to-monitor $external_monitor
  done

  bspc desktop Desktop --remove > /dev/null
  bspc desktop Desktop --remove > /dev/null

  for desktop in $(bspc query -D -m $external_monitor | sed "5"q); do
    bspc desktop $desktop --to-monitor $internal_monitor
  done

  bspc desktop Desktop --remove > /dev/null
  bspc desktop Desktop --remove > /dev/null

  polybar main-ubuntu &
  polybar secondary-ubuntu &

  notify-send "Dual Monitor mode launched."
}

monitor_remove() {
  if [[ "$(bspc query -M | wc -l)" = 1 ]]; then
    polybar main-ubuntu &
    exit
  fi
  bspc monitor $external_monitor -a Desktop > /dev/null

  for desktop in $(bspc query -D -m $external_monitor | sed "4"q); do
    bspc desktop $desktop --to-monitor $internal_monitor
  done

  bspc monitor $external_monitor --remove > /dev/null

  xrandr --output $external_monitor --off \
    --output $internal_monitor \
    --primary \
    --mode 1920x1080 \
    --pos 0x0 \
    --rate 60 \
    --rotate normal

  bspc desktop Desktop --remove > /dev/null

  polybar main-ubuntu &

  notify-send "Single Monitor mode launched."
}

# I don't want hotplug mode to run if using my desktop
# hostname check can be removed or replaced with your own hostnames
if [[ $(hostname) == "arch-pc" ]]; then
  xrandr --output DVI-D-1 --mode 1920x1080 --rate 144 --primary
  polybar main-arch &
elif [[ $(hostname) == "TA-NISMI-E490" ]]; then
  if xrandr | grep -o "$external_monitor connected" > /dev/null && [[ "$1" != "1" ]] && [[ "$(bspc query -M | wc -l)" != 2 ]]; then
    monitor_add
  else
    monitor_remove
  fi
fi
