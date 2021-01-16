#!/bin/sh
# This script is run when Gnome is started

xrdb .Xresources
.local/bin/keyboard.sh
.local/bin/mattermost-desktop/mattermost-desktop &
birdtray &
