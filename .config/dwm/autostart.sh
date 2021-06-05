#!/usr/bin/env bash
_run() {
  if ! pgrep -x "${1}" &>/dev/null; then
      "$@" &
  fi
}
# detect screen layout
autorandr -c

source ~/.bashrc
xrdb .Xresources

# keyboard
~/.local/bin/keyboard.sh
# wallapaper
~/.local/bin/setbg.sh

# cursor and fonts
xsetroot -cursor_name left_ptr &
xset +fp ~/.fonts &
xset fp rehash &
fc-cache -fv &
xbacklight -set 100%

_run dunst --config ~/.config/dunst/dunstrc
_run transmission-daemon
_run mpd
_run signal-desktop --start-in-tray --use-tray-icon
_run light-locker --lock-on-suspend --lock-after-screensaver=30
_run dwmblocks

if [[ -z $(which picom) ]]; then
  _run ~/.local/bin/picom/build/src/picom --config .config/picom/picom.conf --experimental-backends --vsync
else
  _run picom --config .config/picom/picom.conf --experimental-backends --vsync
fi
