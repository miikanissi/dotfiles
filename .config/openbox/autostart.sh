#!/bin/sh

# ~/-config/openbox/autostart.sh
# This file runs when openbox session is started

.local/bin/144.sh & # Runs a script to set refresh rate for 144Hz
.local/bin/setbg.sh & # Runs a script to restore wallpaper

clipit & # Starts clipboard manager
tint2 & # Starts tint2 panel
volumeicon & # Adds volumeicon to tint2 panel
dunst -config ~/.config/dunst/dunstrc & # Starts notification manager
xbindkeys & # Starts xbindkeys
compton -b -c & # Starts compositor
xset r rate 300 50 & # Speeds up xrate

