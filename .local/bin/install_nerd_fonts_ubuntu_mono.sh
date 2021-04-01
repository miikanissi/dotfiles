#!/usr/bin/env bash
# curls the Blex Mono Nerd Font Complete v2.1.0 and installs it to ~/.local/share/fonts
dl_dir=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip -o $dl_dir/UbuntuMono.zip
unzip -u $dl_dir/UbuntuMono.zip -d ~/.local/share/fonts/
fc-cache -fv
