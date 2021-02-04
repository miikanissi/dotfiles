#!/usr/bin/env bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# script to run when bspwm starts

_run() {
    if ! pgrep -x "${1}" &>/dev/null; then
        "$@" &
    fi
}
# detect screen layout
autorandr -c

source ~/.bashrc
source ~/.xprofile
xrdb .Xresources &

# keyboard
~/.local/bin/keyboard.sh &

# cursor and fonts
xsetroot -cursor_name left_ptr &
xset +fp ~/.fonts &
xset fp rehash &
fc-cache -fv &

# keymaps
_run sxhkd -m -1 > /tmp/sxhkd.log

xbacklight -set 100%

_run dunst --config ~/.config/dunst/dunstrc
_run transmission-daemon
_run mpd
_run signal-desktop --start-in-tray --use-tray-icon
_run light-locker --lock-on-suspend --lock-after-screensaver=30

if [[ -z $(which picom) ]]; then
  _run ~/.local/bin/picom/build/src/picom --config .config/picom/picom.conf --experimental-backends --vsync
else
  _run picom --config .config/picom/picom.conf --experimental-backends --vsync
fi
