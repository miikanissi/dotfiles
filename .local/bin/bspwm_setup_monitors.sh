#!/usr/bin/env bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# hotplug mode for bspwm and polybar with autorandr

## Notify BSPWM to run this script for all xrandr changes by adding it to:
## ~/.config/autorandr/postswitch
## See Hook scripts: https://github.com/phillipberndt/autorandr
##
## autorandr installs a udev rule which is triggered when monitor state is changed
## rule file: /usr/lib/udev/rules.d/40-monitor-hotplug.rules
## autorandr udev rule:
##   ACTION=="change", SUBSYSTEM=="drm", RUN+="/bin/systemctl start --no-block autorandr.service"
WM=$(wmctrl -m | grep Name: | awk '{print $2}')
if [[ "$WM" != "BSPWM" ]]; then
  exit 0
fi
PRIMARY_MONITOR=$(xrandr | grep primary | cut -d ' ' -f 1)
MONITORS=($(xrandr --listactivemonitors | awk '{print $4}' | sed '/^$/d'))
BSPWM_MONITORS=$(bspc query -M --names)

_desk_order() {
  while read -r line; do
    printf "%s\\n" "$line"
  done < <(bspc query -D -m "${1:-focused}" --names) | sort -g | paste -d ' ' -s
}

_set_bspwm_config() {
  # apply the bspwm configs escept external_rules_command
  # or the desktops will look funny if monitors have changed
  while read line ; do
    $line
  done < <(grep --color=never -E \
    '(split_ratio|border_width|window_gap|top_padding|bottom_padding|left_padding|right_padding)' ~/.config/bspwm/bspwmrc)
  }

# bspwm creates default desktops, remove them
_remove_default_desktops(){
  for d in $(bspc query -D --names); do
    if [[ "$d" == "Desktop" ]]; then
      bspc desktop $d --remove
    fi
  done
}

# moves all desktops to main monitor
_to_main_monitor() {
  for m in ${BSPWM_MONITORS[@]}; do
    if [[ $m != $PRIMARY_MONITOR ]]; then
      bspc monitor $m -a Desktop > /dev/null
      for desktop in $(bspc query -D -m $m); do
        if [[ "$desktop" != "Desktop" ]]; then
          bspc desktop $desktop --to-monitor $PRIMARY_MONITOR
        fi
      done
      _remove_default_desktops
    fi
  done
}

# some hacky logic to move desktops around
case ${#MONITORS[@]} in
  1)
    # if no desktops create them
    if [[ $(bspc query -D | wc -w) < 3 ]]; then
      bspc monitor $PRIMARY_MONITOR -d 1 2 3 4 5 6
    # move desktops to single monitor and delete monitors
    else
      _to_main_monitor
      for m in $BSPWM_MONITORS; do
        if [[ ${m} != ${PRIMARY_MONITOR} ]]; then
          bspc monitor $m --remove > /dev/null
        fi
      done
    fi
    ;;
  *)
    # if no desktops present create them
    if [[ $(bspc query -D | wc -w) < 3 ]]; then
      bspc monitor $PRIMARY_MONITOR -d 1 2 3 4
      for m in ${MONITORS[@]}; do
        if [[ ${m} != ${PRIMARY_MONITOR} ]]; then
          bspc monitor $m -d 5 6
        fi
      done
    else
      # first move all desktops to primary monitor
      _to_main_monitor
      _remove_default_desktops
      bspc monitor $PRIMARY_MONITOR -o $(eval _desk_order $PRIMARY_MONITOR)
      # move two desktops to secondary monitor(s)
      for m in ${MONITORS[@]}; do
        if [[ ${m} != ${PRIMARY_MONITOR} ]]; then
          for desktop in $(bspc query -D -m $PRIMARY_MONITOR | tac | sed "2"q | tac); do
            bspc desktop $desktop --to-monitor $m
          done
        fi
      done
      _remove_default_desktops
    fi
    ;;
esac

_remove_default_desktops
# reorder the desktops for each monitor
for m in ${MONITORS[@]}; do
  bspc monitor $m -o $(eval _desk_order $MONITOR)
done

_set_bspwm_config
.local/bin/keyboard.sh # set keyboard conf
~/.local/bin/setbg.sh & # set wallpaper
~/.local/bin/polybar_launch.sh & # launch polybar
