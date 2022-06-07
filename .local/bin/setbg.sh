#!/bin/bash

[ -f "$1" ] && cp "$1" ~/.local/share/wall.jpg

feh --no-fehbg --bg-scale ~/.local/share/wall.jpg
