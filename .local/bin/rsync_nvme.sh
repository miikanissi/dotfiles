#!/bin/bash
mount_point=/media/nvme

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after \
    --exclude '.local/share/Trash' \
    --exclude '.cache' \
    --exclude '.config/BraveSoftware' \
    --exclude '.config/Signal' \
    /home/miika $mount_point/backup
fi
