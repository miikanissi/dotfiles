#!/usr/bin/env bash

disconnected=""
wireless_connected=""
ethernet_connected=""

ID="$(ip link | awk '/state UP/ {print $2}')"

if (ping -c 1 archlinux.org || ping -c 1 duckduckgo.com || ping -c 1 bitbucket.org || ping -c 1 github.com || ping -c 1 sourceforge.net) &>/dev/null; then
    if [[ $ID == e* ]]; then
        echo "$ethernet_connected"
    else
        echo "$wireless_connected"
    fi
else
    echo "$disconnected"
fi
