#!/bin/sh
# This script is run when Gnome is started

xrdb .Xresources
setxkbmap -option grp:switch -option grp_led:scroll us,fi
xset r rate 300 50
