#!/usr/bin/env bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# hotplug mode for bspwm and polybar with autorandr
# this script is run on bspwm startup and autorandr monitor change

## Notify BSPWM to run this script for all xrandr changes by adding it to:
## ~/.config/autorandr/postswitch
## See Hook scripts: https://github.com/phillipberndt/autorandr
##
## autorandr installs a udev rule which is triggered when monitor state is changed
## rule file: /usr/lib/udev/rules.d/40-monitor-hotplug.rules
## autorandr udev rule:
##   ACTION=="change", SUBSYSTEM=="drm", RUN+="/bin/systemctl start --no-block autorandr.service"

# Exit script if not on bspwm
WM=$(wmctrl -m | grep Name: | awk '{print $2}')
if [[ "${WM}" != "bspwm" ]]; then
  exit 0
fi

# Get primary and secondary monitor
# use mapfile to create arrays of monitors
mapfile -t MONITORS < <(xrandr | grep " connected " | awk '{ print $1 }')

PRIMARY_MONITOR=$(xrandr | grep primary | cut -d ' ' -f 1)
SECONDARY_MONITOR=""

if [ "${#MONITORS[@]}" -eq 2 ]; then
  for m in "${MONITORS[@]}"; do
    if [[ "${m}" != "${PRIMARY_MONITOR}" ]]; then
      SECONDARY_MONITOR="${m}"
    fi
  done
fi

INTERNAL_MONITOR=eDP
EXTERNAL_MONITOR=HDMI1

monitor_add() {
  # Move first 5 desktops to external monitor
  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 5q); do
    bspc desktop "$desktop" --to-monitor "$EXTERNAL_MONITOR"
  done
  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove
}

monitor_remove() {
  # Add default temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$INTERNAL_MONITOR" -a Desktop

  # Move all desktops except the last default desktop to disconnected
  # external monitor to reorder desktops
  for desktop in $(bspc query -D -m "$INTERNAL_MONITOR"); do
		bspc desktop "$desktop" --to-monitor "$EXTERNAL_MONITOR"
	done

  # Add default temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$EXTERNAL_MONITOR" -a Desktop

  # Move all desktops except the last default desktop to internal monitor
  for desktop in $(bspc query -D -m "$EXTERNAL_MONITOR");	do
		bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
	done

  # delete default desktops
  bspc desktop Desktop --remove
  bspc desktop Desktop --remove
}

if [[ $(xrandr -q | grep -q "${EXTERNAL_MONITOR} connected") ]]; then
    monitor_add
else
    monitor_remove
fi

# Set wallpaper
~/.local/bin/setbg.sh &

# Launch polybar
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 2; done

polybar --reload primary -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &

if [[ $(xrandr -q | grep -q "${EXTERNAL_MONITOR} connected") ]]; then
  polybar --reload secondary -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-secondary.log 2>&1 200>&- &
fi
