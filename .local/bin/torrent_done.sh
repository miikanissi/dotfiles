#!/bin/sh
# sends a notification when a torrent is completed in transmission
# signals an update to the bar torrent module

notify-send "Transmission-daemon" "$TR_TORRENT_NAME has finished downloading." && polybar-msg hook torrents 1
