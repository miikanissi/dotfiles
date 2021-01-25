#!/bin/bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# rofi/dmenu prompt to manage devices

prompt="$(echo -e "mount\numount\neject\nlsblk" | rofi -dmenu -p "Disk Manager")"
if [ $prompt = mount ]; then
  dev=$(echo $(lsblk -lp | grep -E "/dev/.*part" | awk '{print $1}' | rofi -dmenu -p "Device to mount:"))
  [ -z $dev ] && exit 0;
  devname=$(echo -n $dev | sed 's/\//\n/g' | tail -n 1)
  if [ -z $(mount | grep $dev) ]; then
    if $(sudo cryptsetup isLuks $dev); then
      pass=$(rofi -dmenu -password -p "Enter passphrase for $dev:")
      dir=$(find /mnt/ -mindepth 1 -maxdepth 1 | rofi -dmenu -p "Mount $dev to:")
      [[ -z $pass || -z $dir ]] && exit 0;
      echo hi
      echo -n $pass | sudo cryptsetup luksOpen $dev $devname -d -
      sudo mount /dev/mapper/$devname $dir
      if mountpoint -q -- $dir; then
        notify-send "$dev mounted to $dir"
      else
        notify-send "Mount failed"
      fi
    else
      dir=$(find /mnt/ -mindepth 1 -maxdepth 1 | rofi -dmenu -p "Mount $dev to:")
      [ -z $dir ] && exit 0;
      sudo mount $dev $dir
      if mountpoint -q -- $dir; then
        notify-send "$dev mounted to $dir"
      else
        notify-send "Mount failed"
      fi
    fi
  else
    notify-send "$dev is already mounted"
    exit 0;
  fi
elif [ $prompt = umount ]; then
  dev=$(echo $(lsblk -lp | grep -E "/dev/.*part|/dev/.*crypt" | awk '{print $1}' | rofi -dmenu -p "Device to unmount:"))
  [ -z $dev ] && exit 0;
  if [ -z $(mount | grep $dev) ]; then
    notify-send "$dev is already unmounted"
    exit 0;
  else
    sudo umount $dev
    if [ -z $(mount | grep $dev) ]; then
      if [ -z $(echo $dev | grep "mapper") ]; then
        notify-send "$dev unmounted succesfully"
      else
        sudo cryptsetup luksClose $dev
        notify-send "$dev unmounted succesfully"
      fi
    else
      notify-send "Unmount failed"
    fi
  fi
elif [ $prompt = eject ]; then
  dev=$(echo $(lsblk -lp | grep -E "/dev/.*disk" | awk '{print $1}' | rofi -dmenu -p "Device to eject:"))
  [ -z $dev ] && exit 0;
  sudo eject $dev
  if [ -z $(lsblk -lp | grep $dev) ]; then
    notify-send "$dev ejected succesfully"
  else
    notify-send "Eject failed"
  fi
elif [ $prompt = lsblk ]; then
  notify-send "$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT)"
fi
