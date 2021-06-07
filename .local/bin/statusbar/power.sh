case $BUTTON in
  1) notify-send "Powermenu
  Right click: Suspend
  Shift + Right click: Power Off
  Shift + Left click: Reboot" ;;
  3) sudo systemctl suspend ;;
  6) sudo systemctl reboot ;;
  7) sudo systemctl poweroff ;;
esac

echo 
