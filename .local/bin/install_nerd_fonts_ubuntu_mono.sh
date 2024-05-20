#!/usr/bin/env bash
# curls the Ubuntu/Ubuntu Mono Nerd Fonts v3.2.1 and installs it to ~/.local/share/fonts
dl_dir=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip -o "$dl_dir"/UbuntuMono.zip
unzip -u "$dl_dir"/UbuntuMono.zip -d ~/.local/share/fonts/
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip -o "$dl_dir"/Ubuntu.zip
unzip -u "$dl_dir"/Ubuntu.zip -d ~/.local/share/fonts/
fc-cache -fv
