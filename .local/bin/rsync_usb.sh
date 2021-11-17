#!/bin/bash
mount_point=/mnt/usb

if mountpoint -q -- $mount_point; then
  sudo rsync -avhPWr --delete-after \
    --exclude 'Music' \
    --exclude 'Downloads' \
    --exclude 'Videos' \
    --exclude 'dotfiles' \
    --exclude 'node_modules' \
    --exclude 'jagex_cl_oldschool_LIVE.dat' \
    --exclude 'random.dat' \
    --exclude 'package.json' \
    --exclude 'package-lock.json' \
    --exclude 'jagexcache' \
    --include '.emacs.d' \
    --include '.emacs.d/.secret.el' \
    --include '.ssh' \
    --include '.gnupg' \
    --include '.password-store/***' \
    --include '.password-store/**' \
    --include '.password-store/*' \
    --include '.password-store/' \
    --include '.password-store' \
    --include '.gitconfig' \
    --include '.minecraft/' \
    --include '.minecraft/saves/***' \
    --exclude '.**' \
    /home/m/ $mount_point/backup
fi
