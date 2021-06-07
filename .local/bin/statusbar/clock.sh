#!/bin/sh

case $BUTTON in
	1) setsid -f $TERMINAL -e calcurse ;;
esac
date "+ %Y %b %d (%a), %-I:%M%p"
