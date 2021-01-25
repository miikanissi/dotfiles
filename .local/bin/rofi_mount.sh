#!/bin/bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi

prompt="$(echo -e "mount\numount\nlsblk" | rofi -dmenu)"
if [ $prompt = mount ]; then
  dev=$(echo $(lsblk -lp | grep -E "/dev/.*part" | awk '{print $1}' | rofi -dmenu))
  [ -z $dev ] && exit 0;
  devname=$(echo -n $dev | sed 's/\//\n/g' | tail -n 1)
  if [ -z $(mount | grep $dev) ]; then
    if $(sudo cryptsetup isLuks $dev); then
      pass=$(rofi -dmenu -password -p "Enter passphrase for $dev:")
      dir=$(find /mnt/ -mindepth 1 -maxdepth 1 | rofi -dmenu -p "Mount $dev to:")
      [[ -z $pass || -z $dir ]] || exit 0;
      echo -n $pass | sudo cryptsetup luksOpen $dev $devname -d -
      if [ -c /dev/mapper/$devname ]; then
        sudo mount /dev/mapper/$devname $dir
        if mountpoint -q -- $dir; then
          notify-send "$dev mounted to $dir"
        else
          notify-send "Mount failed"
        fi
      else
        notify-send "luksOpen failed"
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
elif [ $prompt = lsblk ]; then
  notify-send "$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT)"
fi
