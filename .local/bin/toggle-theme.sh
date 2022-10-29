#!/usr/bin/env bash
# Toggles theme from dark mode to light mode

ALACRITTY_DARK=(sed -i 's/modus-operandi.yml/modus-vivendi.yml/g' ~/.config/alacritty/theme.yml)
ALACRITTY_LIGHT=(sed -i 's/modus-vivendi.yml/modus-operandi.yml/g' ~/.config/alacritty/theme.yml)
DUNST_DARK_COMMENT=(sed -i '/^# BEGIN DARK$/,/^# END DARK$/ s/^/#/' ~/.config/dunst/dunstrc)
DUNST_DARK_UNCOMMENT=(sed -i '/^## BEGIN DARK$/,/^## END DARK$/ s/^#//' ~/.config/dunst/dunstrc)
DUNST_LIGHT_COMMENT=(sed -i '/^# BEGIN LIGHT$/,/^# END LIGHT$/ s/^/#/' ~/.config/dunst/dunstrc)
DUNST_LIGHT_UNCOMMENT=(sed -i '/^## BEGIN LIGHT$/,/^## END LIGHT$/ s/^#//' ~/.config/dunst/dunstrc)
X_DARK_COMMENT=(sed -i '/^! BEGIN DARK$/,/^! END DARK$/ s/^/!/' ~/.Xresources)
X_DARK_UNCOMMENT=(sed -i '/^!! BEGIN DARK$/,/^!! END DARK$/ s/^!//' ~/.Xresources)
X_LIGHT_COMMENT=(sed -i '/^! BEGIN LIGHT$/,/^! END LIGHT$/ s/^/!/' ~/.Xresources)
X_LIGHT_UNCOMMENT=(sed -i '/^!! BEGIN LIGHT$/,/^!! END LIGHT$/ s/^!//' ~/.Xresources)
GTK2_DARK=(sed -i 's/"oomox-modus-operandi"/"oomox-modus-vivendi"/g' ~/.gtkrc-2.0)
GTK2_LIGHT=(sed -i 's/"oomox-modus-vivendi"/"oomox-modus-operandi"/g' ~/.gtkrc-2.0)
GTK3_DARK=(sed -i 's/oomox-modus-operandi/oomox-modus-vivendi/g' ~/.config/gtk-3.0/settings.ini)
GTK3_LIGHT=(sed -i 's/oomox-modus-vivendi/oomox-modus-operandi/g' ~/.config/gtk-3.0/settings.ini)
ROFI_DARK=(sed -i 's/"modus-operandi"/"modus-vivendi"/g' ~/.config/rofi/config.rasi)
ROFI_LIGHT=(sed -i 's/"modus-vivendi"/"modus-operandi"/g' ~/.config/rofi/config.rasi)
NVIM_LIGHT=(sed -i 's/modus-vivendi/modus-operandi/g ; s/"dark"/"light"/g' ~/.config/nvim/init.lua)
NVIM_DARK=(sed -i 's/modus-operandi/modus-vivendi/g ; s/"light"/"dark"/g' ~/.config/nvim/init.lua)

usage () {
    printf "Usage: toggle-theme.sh [OPTION]\nOptions:\n  -d     Turn dark mode on\n  -l     Turn light mode on\n  -t     Toggles dark/light mode\n  -q     Query the current mode\n"
}
query (){
  if grep -q '^!! BEGIN DARK$' ~/.Xresources; then
    echo ""
  else
    echo ""
  fi
}
refresh (){
  xrdb ~/.Xresources
  killall dunst && dunst --config ~/.config/dunst/dunstrc &
  killall pcmanfm
  if [[ "$(wmctrl -m | grep Name | awk '{print $2}')" == "LG3D" ]]; then
    bspc wm -r
  fi
}
dark () {
  if grep -q '^!! BEGIN DARK$' ~/.Xresources; then
    "${DUNST_DARK_UNCOMMENT[@]}"
    "${DUNST_LIGHT_COMMENT[@]}"
    "${X_DARK_UNCOMMENT[@]}"
    "${X_LIGHT_COMMENT[@]}"
    "${GTK3_DARK[@]}"
    "${GTK2_DARK[@]}"
    "${ROFI_DARK[@]}"
    "${NVIM_DARK[@]}"
    "${ALACRITTY_DARK[@]}"
    refresh
  fi
  echo ""
}
light () {
  if grep -q '^!! BEGIN LIGHT$' ~/.Xresources; then
    "${DUNST_LIGHT_UNCOMMENT[@]}"
    "${DUNST_DARK_COMMENT[@]}"
    "${X_LIGHT_UNCOMMENT[@]}"
    "${X_DARK_COMMENT[@]}"
    "${GTK3_LIGHT[@]}"
    "${GTK2_LIGHT[@]}"
    "${ROFI_LIGHT[@]}"
    "${NVIM_LIGHT[@]}"
    "${ALACRITTY_LIGHT[@]}"
    refresh
  fi
  echo ""
}
toggle () {
  if grep -q '^!! BEGIN DARK$' ~/.Xresources; then
    dark
  else
    light
  fi
}

while getopts "tldqh" o; do case "${o}" in
  h) usage && exit 1;;
  t) toggle ;;
  l) light ;;
  d) dark ;;
  q) query ;;
  *) printf "Invalid option: -%s\\n  -h: To show help\\n" "$OPTARG" && exit 1 ;;
esac done
