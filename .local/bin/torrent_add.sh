#!/bin/sh

# Mime map script for adding a magnet link to transmission, and starts the daemon if it's not running
# Sends a notification when a torrent is added to transmission

pgrep -x transmission-daemon > /dev/null || transmission-daemon

transmission-remote -a "$@" && notify-send "Transmission-daemon" "Torrent added."
