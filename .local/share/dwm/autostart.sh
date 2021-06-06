#!/usr/bin/env bash
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

dunst --config ~/.config/dunst/dunstrc &
transmission-daemon &
mpd &
signal-desktop --start-in-tray --use-tray-icon &
light-locker --lock-on-suspend --lock-after-screensaver=30 &
dwmblocks &

if [[ -z $(which picom) ]]; then
  ~/.local/bin/picom/build/src/picom --config .config/picom/picom.conf --experimental-backends --vsync &
else
  picom --config .config/picom/picom.conf --experimental-backends --vsync &
fi
