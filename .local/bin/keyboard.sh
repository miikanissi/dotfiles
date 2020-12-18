#!/bin/sh

xset r rate 300 50 & # makes key repeat faster
setxkbmap -option grp:switch -option grp_led:scroll us,fi
