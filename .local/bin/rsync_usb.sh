#!/bin/bash
mount_point=/mnt/usb

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after \
    --exclude 'Music' \
    --exclude 'Pictures' \
    --exclude 'Videos' \
    --exclude 'Downloads' \
    --include '.config' \
    --include '.ssh' \
    --include '.gnupg' \
    --include '.password-store' \
    --exclude '.*' \
    /home/miika/ $mount_point/backup
fi
