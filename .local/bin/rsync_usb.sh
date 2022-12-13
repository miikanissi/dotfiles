#!/bin/bash
mount_point=/mnt/usb

if mountpoint -q -- $mount_point; then
  sudo rsync -avhPWr --delete-after \
      /home/m/Documents \
      /home/m/Mail \
      /home/m/Videos \
      /home/m/Pictures \
      /home/m/Music \
      /home/m/Pictures \
      /home/m/.ssh \
      /home/m/.gnupg \
      /home/m/.password-store \
      $mount_point/miika-backup
fi
