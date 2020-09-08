#!/bin/sh

# uncomment for scrot
# scrot -s -e 'mv $f ~/pics/ss/'

# takes screenshot of selected region
# pipes into tee which saves image and passes standard output onto
# xclip for pasting
maim -s | tee ~/pics/ss/$(date +%s).png | xclip -selection clipboard -t image/png

