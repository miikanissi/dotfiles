#!/bin/bash

case $BUTTON in
  1) xset s off s noblank -dpms ;;
  3) xset s on s blank -dpms ;;
esac

if [ "$(xset q | grep timeout | awk '{print $2}')" == "0" ]; then
  echo ""
else
  echo ""
fi
