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

_desk_order() {
  while read -r line; do
    printf "%s\\n" "$line"
  done < <(bspc query -D -m "${1:-focused}" --names) | sort -g | paste -d ' ' -s
}

_set_bspwm_config() {
  ## apply the bspwm configs escept external_rules_command
  ## or the desktops will look funny if monitors have changed
  while read line ; do
    $line
  done < <(grep --color=never -E \
    '(split_ratio|border_width|window_gap|top_padding|bottom_padding|left_padding|right_padding)' ~/.config/bspwm/bspwmrc)
  }

_move_to_single_monitor() {
  move_from=$1
  move_to=$2

  bspc monitor $move_from -a Desktop > /dev/null
  for desktop in $(bspc query -D -m $move_from); do
    if [[ "$desktop" != "Desktop" ]]; then
      bspc desktop $desktop --to-monitor $move_to
    fi
  done
  bspc desktop Desktop --remove > /dev/null
  bspc monitor $move_from --remove > /dev/null
}

_move_to_dual_monitor(){
  primary=$1
  secondary=$2
  # move 4 desktops to main screen leaving 2 on secondary screen
  for desktop in $(bspc query -D -m $secondary | sed "4"q); do
    bspc desktop $desktop --to-monitor $primary
  done
}

PRIMARY_MONITOR=$(xrandr | grep primary | cut -d ' ' -f 1)
OUTPUTS=($(xrandr --listactivemonitors|awk '{print $4}'|sed '/^$/d'))
NB_OF_MONITORS=${#OUTPUTS[@]}
OUTPUTS_BSPWM=$(bspc query -M --names)
NB_OF_MONITORS_BSPWM=$(bspc query -M --names | wc -w)
# very hacky logic to move desktops around
for MONITOR in ${OUTPUTS[@]}; do
  case $NB_OF_MONITORS in
    1)
      if [[ $NB_OF_MONITORS_BSPWM > 1 ]]; then
        for m in ${OUTPUTS_BSPWM[@]}; do
          if [[ $m != $MONITOR ]]; then
            _move_to_single_monitor $m $MONITOR
          fi
        done
      else
        bspc monitor $MONITOR -d 1 2 3 4 5 6
      fi
      ;;
    2)
      # if no desktops present create them
      if [[ $(bspc query -D | wc -w) < 3 ]]; then
        if [[ ${MONITOR} != ${PRIMARY_MONITOR} ]]; then
          bspc monitor $PRIMARY_MONITOR -d 1 2 3 4
          bspc monitor $MONITOR -d 5 6
          continue
        fi
      # organize desktops for two monitors
      elif [[ ${MONITOR} != ${PRIMARY_MONITOR} ]] && [[ $(bspc query -D -m $MONITOR | wc -w) > 3 ]]; then
        _move_to_dual_monitor $PRIMARY_MONITOR $MONITOR
        continue
      fi
      ;;
    *)
      if [[ ${MONITOR} == ${PRIMARY_MONITOR} ]]; then
        bspc monitor $MONITOR -d 1 2 3 4
      else
        bspc monitor $MONITOR -d 1 2
      fi
      ;;
  esac
  # reorder the desktops for each monitor
  bspc monitor $MONITOR -o $(eval _desk_order $MONITOR)
done

_set_bspwm_config

.local/bin/keyboard.sh # set keyboard conf
~/.local/bin/setbg.sh & # set wallpaper
~/.local/bin/polybar_launch.sh & # launch polybar
