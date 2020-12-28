#!/bin/sh
# mount LUKS partition of usb device

cryptsetup luksOpen /dev/sdb1 usbhome
mount /dev/mapper/usbhome /media/usb/
