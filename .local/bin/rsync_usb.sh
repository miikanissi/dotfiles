#!/bin/bash
mount_point=/media/usb

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after \
    --exclude '.*' \
    --exclude 'Music' \
    --exclude 'Pictures' \
    --exclude 'Videos' \
    --exclude 'Downloads' \
    --exclude 'go' \
    --include '.ssh' \
    --include '.gnupg' \
    /home/miika/ $mount_point/backup
fi
