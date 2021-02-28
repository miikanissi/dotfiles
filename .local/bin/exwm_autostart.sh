#!/usr/bin/env bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# script to run on EXWM startup

_run() {
    if ! pgrep -x "${1}" &>/dev/null; then
        "$@" &
    fi
}

# Internal laptop monitor
xrandr --addmode eDP-1 1920x1080_60.00
xrandr --output eDP-1 --mode 1920x1080_60.00
# External monitor on the dock
xrandr --addmode DP-2-2 1920x1080_60.00
xrandr --output DP-2-2 --mode 1920x1080_60.00

source ~/.bashrc
xrdb .Xresources &

# keyboard setup
~/.local/bin/keyboard.sh
# cursor and fonts
xsetroot -cursor_name left_ptr &
xset +fp ~/.fonts &
xset fp rehash &
fc-cache -fv &

_run dunst --config ~/.config/dunst/dunstrc
_run mpd
_run signal-desktop --start-in-tray --use-tray-icon
_run nm-applet

# compositor
if [[ -z $(which picom) ]]; then
  _run ~/.local/bin/picom/build/src/picom --config .config/picom/picom.conf --experimental-backends --vsync
else
  _run picom --config .config/picom/picom.conf --experimental-backends --vsync
fi
