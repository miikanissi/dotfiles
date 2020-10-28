#!/bin/sh

# Mimeapp script for adding torrent to transmission-daemon, but will also start the daemon first if not running.

# transmission-daemon sometimes fails to take remote requests in its first moments, hence the sleep.

transmission-gtk "$@" && notify-send "Torrent added."
