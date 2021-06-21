#!/usr/bin/env bash
# Toggles theme from dark mode to light mode

# sed to comment/uncomment ~/.Xresources. Make sure the file is formatted correctly
COMMENT_DARK_X=(sed -e '/DARK START/,/DARK END/ s/^/!/' -i ~/.Xresources)
UNCOMMENT_DARK_X=(sed -e '/DARK START/,/DARK END/ s/^.//' -i ~/.Xresources)
COMMENT_LIGHT_X=(sed -e '/LIGHT START/,/LIGHT END/ s/^/!/' -i ~/.Xresources)
UNCOMMENT_LIGHT_X=(sed -e '/LIGHT START/,/LIGHT END/ s/^.//' -i ~/.Xresources)
COMMENT_DARK_KITTY=(sed -e '/DARK START/,/DARK END/ s/^/#/' -i ~/.config/kitty/kitty.conf)
UNCOMMENT_DARK_KITTY=(sed -e '/DARK START/,/DARK END/ s/^.//' -i ~/.config/kitty/kitty.conf)
COMMENT_LIGHT_KITTY=(sed -e '/LIGHT START/,/LIGHT END/ s/^/#/' -i ~/.config/kitty/kitty.conf)
UNCOMMENT_LIGHT_KITTY=(sed -e '/LIGHT START/,/LIGHT END/ s/^.//' -i ~/.config/kitty/kitty.conf)
COMMENT_DARK_DUNST=(sed -e '/DARK START/,/DARK END/ s/^/#/' -i ~/.config/dunst/dunstrc)
UNCOMMENT_DARK_DUNST=(sed -e '/DARK START/,/DARK END/ s/^.//' -i ~/.config/dunst/dunstrc)
COMMENT_LIGHT_DUNST=(sed -e '/LIGHT START/,/LIGHT END/ s/^/#/' -i ~/.config/dunst/dunstrc)
UNCOMMENT_LIGHT_DUNST=(sed -e '/LIGHT START/,/LIGHT END/ s/^.//' -i ~/.config/dunst/dunstrc)
LIGHT_GTK_THEME=Adwaita
DARK_GTK_THEME=Adwaita-dark
LIGHT_ROFI_THEME=base16-papercolor-light.rasi
DARK_ROFI_THEME=base16-papercolor-dark.rasi

# Check .Xresources, if light mode, change to dark mode
if grep -q '^!! DARK START$' ~/.Xresources && grep -q '^! LIGHT START$' ~/.Xresources && grep -q '^## DARK START$' ~/.config/kitty/kitty.conf && grep -q '^# LIGHT START$' ~/.config/kitty/kitty.conf && grep -q '^## DARK START$' ~/.config/dunst/dunstrc && grep -q '^# LIGHT START$' ~/.config/dunst/dunstrc; then
  "${COMMENT_LIGHT_X[@]}"
  "${UNCOMMENT_DARK_X[@]}"
  "${COMMENT_LIGHT_KITTY[@]}"
  "${UNCOMMENT_DARK_KITTY[@]}"
  "${COMMENT_LIGHT_DUNST[@]}"
  "${UNCOMMENT_DARK_DUNST[@]}"
  xrdb ~/.Xresources
  sed -i "/gtk-theme-name=/c\gtk-theme-name=$DARK_GTK_THEME" ~/.config/gtk-3.0/settings.ini
  sed -i "/gtk-theme-name=/c\gtk-theme-name=\"$DARK_GTK_THEME\"" ~/.gtkrc-2.0
  sed -i "/set background=/c\set background=dark" ~/.vim/vimrc
  sed -i "/theme:/c\    theme: \"$DARK_ROFI_THEME\";" ~/.config/rofi/config.rasi
  kitty @ --to=tcp:localhost:12344 set-colors --all --configured ~/.config/kitty/kitty.conf
  killall dunst && dunst --config ~/.config/dunst/dunstrc &
  if [[ "$(wmctrl -m | grep Name | awk '{print $2}')" == "bspwm" ]]; then
    bspc wm -r
  fi
  xdotool key "Super+F5"
  # signal st to reload
  kill -USR1 "$(pidof st)"
  # sleep as dunst restarts
  sleep 2
  notify-send "Dark Mode enabled"
  exit 1;
fi
# Check .Xresources, if dark mode, change to light mode
if grep -q '^! DARK START$' ~/.Xresources | grep -q '^!! LIGHT START$' ~/.Xresources && grep -q '^# DARK START$' ~/.config/kitty/kitty.conf && grep -q '^## LIGHT START$' ~/.config/kitty/kitty.conf && grep -q '^# DARK START$' ~/.config/dunst/dunstrc && grep -q '^## LIGHT START$' ~/.config/dunst/dunstrc; then
  "${COMMENT_DARK_X[@]}"
  "${UNCOMMENT_LIGHT_X[@]}"
  "${COMMENT_DARK_KITTY[@]}"
  "${UNCOMMENT_LIGHT_KITTY[@]}"
  "${COMMENT_DARK_DUNST[@]}"
  "${UNCOMMENT_LIGHT_DUNST[@]}"
  xrdb ~/.Xresources
  sed -i "/gtk-theme-name=/c\gtk-theme-name=$LIGHT_GTK_THEME" ~/.config/gtk-3.0/settings.ini
  sed -i "/gtk-theme-name=/c\gtk-theme-name=\"$LIGHT_GTK_THEME\"" ~/.gtkrc-2.0
  sed -i "/set background=/c\set background=light" ~/.vim/vimrc
  sed -i "/theme:/c\    theme: \"$LIGHT_ROFI_THEME\";" ~/.config/rofi/config.rasi
  kitty @ --to=tcp:localhost:12344 set-colors --all --configured ~/.config/kitty/kitty.conf
  killall dunst && dunst --config ~/.config/dunst/dunstrc &
  if [[ "$(wmctrl -m | grep Name | awk '{print $2}')" == "bspwm" ]]; then
    bspc wm -r
  fi
  xdotool key "Super+F5"
  # signal st to reload
  kill -USR1 "$(pidof st)"
  # sleep as dunst restarts
  sleep 2
  notify-send "Light Mode enabled"
  exit 1;
fi
