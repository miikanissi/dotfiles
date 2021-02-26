#!/usr/bin/env bash
# curls the Blex Mono Nerd Font Complete v2.1.0 and installs it to ~/.local/share/fonts
dl_dir=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/IBMPlexMono.zip >> $dl_dir/IBMPlexMono.zip
unzip -u $dl_dir/IBMPlexMono.zip -d ~/.local/share/fonts/
fc-cache -fv
