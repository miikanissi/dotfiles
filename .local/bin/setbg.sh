#!/bin/sh

[ -f "$1" ] && cp "$1" ~/.config/wall.jpg
feh --no-fehbg --bg-scale ~/.config/wall.jpg
# xwallpaper --zoom ~/.config/wall.jpg
