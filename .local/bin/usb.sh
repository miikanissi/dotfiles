#!/bin/sh
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# mount/umount LUKS partition of usb device, run with sudo

option=$1
case $option in
  -mount)
    cryptsetup luksOpen /dev/sdc1 usbhome2
    mount /dev/mapper/usbhome2 /media/usb/
    ;;
  -umount)
    umount /media/usb/
    cryptsetup luksClose /dev/mapper/usbhome2
    eject /dev/sdc
    ;;
  *)
    printf "Usage:\\n  -mount: Mount a usb\\n  -umount: Unmount a usb\\n"
    ;;
esac
