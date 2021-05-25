#!/bin/bash
mount_point=/mnt/usb

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after \
    --exclude 'Music' \
    --exclude 'Downloads' \
    --exclude 'Videos' \
    --exclude 'dotfiles' \
    --include '.emacs.d' \
    --include '.emacs.d/.secret.el' \
    --include '.ssh' \
    --include '.gnupg' \
    --include '.password-store' \
    --include '.gitconfig'
    --include '.minecraft/saves'
    --exclude '.*' \
    /home/m/ $mount_point/backup
fi
