#!/bin/sh

[ -f "$1" ] && cp "$1" ~/.config/wall.jpg
feh --bg-scale ~/.config/wall.jpg
# xwallpaper --zoom ~/.config/wall.jpg
