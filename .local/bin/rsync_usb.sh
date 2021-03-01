#!/bin/bash
mount_point=/mnt/usb

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after \
    --exclude 'Music' \
    --exclude 'Downloads' \
    --exclude 'dotfiles' \
    --include '.config/emacs' \
    --include '.ssh' \
    --include '.gnupg' \
    --include '.password-store' \
    --exclude '.*' \
    /home/m/ $mount_point/backup
fi
