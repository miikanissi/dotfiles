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
LIGHT_GTK_THEME=Adwaita
DARK_GTK_THEME=Adwaita-dark

# Check .Xresources, if light mode, change to dark mode
if grep -q '^!! DARK START$' ~/.Xresources && grep -q '^! LIGHT START$' ~/.Xresources && grep -q '^## DARK START$' ~/.config/kitty/kitty.conf && grep -q '^# LIGHT START$' ~/.config/kitty/kitty.conf; then
  "${COMMENT_LIGHT_X[@]}"
  "${UNCOMMENT_DARK_X[@]}"
  "${COMMENT_LIGHT_KITTY[@]}"
  "${UNCOMMENT_DARK_KITTY[@]}"
  xrdb ~/.Xresources
  sed -i "/gtk-theme-name=/c\gtk-theme-name=$DARK_GTK_THEME" ~/.config/gtk-3.0/settings.ini
  sed -i "/gtk-theme-name=/c\gtk-theme-name=\"$DARK_GTK_THEME\"" ~/.gtkrc-2.0
  sed -i "/set background=/c\set background=dark" ~/.vim/vimrc
  sed -i "/theme:/c\    theme: \"base16-papercolor-dark.rasi\";" ~/.config/rofi/config.rasi
  kitty @ --to=tcp:localhost:12344 set-colors --all --configured ~/.config/kitty/kitty.conf
  bspc wm -r
  notify-send "Dark Mode enabled"
  exit 1;
fi
# Check .Xresources, if dark mode, change to light mode
if grep -q '^! DARK START$' ~/.Xresources | grep -q '^!! LIGHT START$' ~/.Xresources && grep -q '^# DARK START$' ~/.config/kitty/kitty.conf && grep -q '^## LIGHT START$' ~/.config/kitty/kitty.conf; then
  "${COMMENT_DARK_X[@]}"
  "${UNCOMMENT_LIGHT_X[@]}"
  "${COMMENT_DARK_KITTY[@]}"
  "${UNCOMMENT_LIGHT_KITTY[@]}"
  xrdb ~/.Xresources
  sed -i "/gtk-theme-name=/c\gtk-theme-name=$LIGHT_GTK_THEME" ~/.config/gtk-3.0/settings.ini
  sed -i "/gtk-theme-name=/c\gtk-theme-name=\"$LIGHT_GTK_THEME\"" ~/.gtkrc-2.0
  sed -i "/set background=/c\set background=light" ~/.vim/vimrc
  sed -i "/theme:/c\    theme: \"base16-papercolor-light.rasi\";" ~/.config/rofi/config.rasi
  kitty @ --to=tcp:localhost:12344 set-colors --all --configured ~/.config/kitty/kitty.conf
  bspc wm -r
  notify-send "Light Mode enabled"
  exit 1;
fi
