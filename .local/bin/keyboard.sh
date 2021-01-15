#!/bin/sh

xset m 1 1 & # mouse acceleration off
xset r rate 300 50 & # makes key repeat faster
setxkbmap -option 'ctrl:swapcaps' -option grp:switch -option grp_led:scroll us,fi
