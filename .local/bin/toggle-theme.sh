#!/usr/bin/env bash
# Toggles theme from dark mode to light mode

ALACRITTY_DARK=(sed -i 's/modus-operandi.toml/modus-vivendi.toml/g' ~/.config/alacritty/theme.toml)
ALACRITTY_LIGHT=(sed -i 's/modus-vivendi.toml/modus-operandi.toml/g' ~/.config/alacritty/theme.toml)
DUNST_DARK_COMMENT=(sed -i '/^# BEGIN DARK$/,/^# END DARK$/ s/^/#/' ~/.config/dunst/dunstrc)
DUNST_DARK_UNCOMMENT=(sed -i '/^## BEGIN DARK$/,/^## END DARK$/ s/^#//' ~/.config/dunst/dunstrc)
DUNST_LIGHT_COMMENT=(sed -i '/^# BEGIN LIGHT$/,/^# END LIGHT$/ s/^/#/' ~/.config/dunst/dunstrc)
DUNST_LIGHT_UNCOMMENT=(sed -i '/^## BEGIN LIGHT$/,/^## END LIGHT$/ s/^#//' ~/.config/dunst/dunstrc)
TMUX_DARK_COMMENT=(sed -i '/^# BEGIN DARK$/,/^# END DARK$/ s/^/#/' ~/.config/tmux/tmux.conf)
TMUX_DARK_UNCOMMENT=(sed -i '/^## BEGIN DARK$/,/^## END DARK$/ s/^#//' ~/.config/tmux/tmux.conf)
TMUX_LIGHT_COMMENT=(sed -i '/^# BEGIN LIGHT$/,/^# END LIGHT$/ s/^/#/' ~/.config/tmux/tmux.conf)
TMUX_LIGHT_UNCOMMENT=(sed -i '/^## BEGIN LIGHT$/,/^## END LIGHT$/ s/^#//' ~/.config/tmux/tmux.conf)
BAT_DARK_COMMENT=(sed -i '/^# BEGIN DARK$/,/^# END DARK$/ s/^/#/' ~/.config/bat/config)
BAT_DARK_UNCOMMENT=(sed -i '/^## BEGIN DARK$/,/^## END DARK$/ s/^#//' ~/.config/bat/config)
BAT_LIGHT_COMMENT=(sed -i '/^# BEGIN LIGHT$/,/^# END LIGHT$/ s/^/#/' ~/.config/bat/config)
BAT_LIGHT_UNCOMMENT=(sed -i '/^## BEGIN LIGHT$/,/^## END LIGHT$/ s/^#//' ~/.config/bat/config)
X_DARK_COMMENT=(sed -i '/^! BEGIN DARK$/,/^! END DARK$/ s/^/!/' ~/.Xresources)
X_DARK_UNCOMMENT=(sed -i '/^!! BEGIN DARK$/,/^!! END DARK$/ s/^!//' ~/.Xresources)
X_LIGHT_COMMENT=(sed -i '/^! BEGIN LIGHT$/,/^! END LIGHT$/ s/^/!/' ~/.Xresources)
X_LIGHT_UNCOMMENT=(sed -i '/^!! BEGIN LIGHT$/,/^!! END LIGHT$/ s/^!//' ~/.Xresources)
QT5_ICON_DARK=(sed -i 's/oomox-modus-operandi/oomox-modus-vivendi/g' ~/.config/qt5ct/qt5ct.conf)
QT5_ICON_LIGHT=(sed -i 's/oomox-modus-vivendi/oomox-modus-operandi/g' ~/.config/qt5ct/qt5ct.conf)
QT5_DARK=(sed -i 's/modus-operandi.conf/modus-vivendi.conf/g' ~/.config/qt5ct/qt5ct.conf)
QT5_LIGHT=(sed -i 's/modus-vivendi.conf/modus-operandi.conf/g' ~/.config/qt5ct/qt5ct.conf)
GTK2_DARK=(sed -i 's/"oomox-modus-operandi"/"oomox-modus-vivendi"/g' ~/.gtkrc-2.0)
GTK2_LIGHT=(sed -i 's/"oomox-modus-vivendi"/"oomox-modus-operandi"/g' ~/.gtkrc-2.0)
GTK3_DARK=(sed -i 's/oomox-modus-operandi/oomox-modus-vivendi/g' ~/.config/gtk-3.0/settings.ini)
GTK3_LIGHT=(sed -i 's/oomox-modus-vivendi/oomox-modus-operandi/g' ~/.config/gtk-3.0/settings.ini)
ROFI_DARK=(sed -i 's/"modus-operandi"/"modus-vivendi"/g' ~/.config/rofi/config.rasi)
ROFI_LIGHT=(sed -i 's/"modus-vivendi"/"modus-operandi"/g' ~/.config/rofi/config.rasi)
NVIM_LIGHT=(sed -i 's/"dark"/"light"/g' ~/.config/nvim/init.lua)
NVIM_DARK=(sed -i 's/"light"/"dark"/g' ~/.config/nvim/init.lua)
SWAY_DARK_COMMENT=(sed -i '/^# BEGIN DARK$/,/^# END DARK$/ s/^/#/' ~/.config/sway/config)
SWAY_DARK_UNCOMMENT=(sed -i '/^## BEGIN DARK$/,/^## END DARK$/ s/^#//' ~/.config/sway/config)
SWAY_LIGHT_COMMENT=(sed -i '/^# BEGIN LIGHT$/,/^# END LIGHT$/ s/^/#/' ~/.config/sway/config)
SWAY_LIGHT_UNCOMMENT=(sed -i '/^## BEGIN LIGHT$/,/^## END LIGHT$/ s/^#//' ~/.config/sway/config)
SWAYNAG_DARK_COMMENT=(sed -i '/^# BEGIN DARK$/,/^# END DARK$/ s/^/#/' ~/.config/swaynag/config)
SWAYNAG_DARK_UNCOMMENT=(sed -i '/^## BEGIN DARK$/,/^## END DARK$/ s/^#//' ~/.config/swaynag/config)
SWAYNAG_LIGHT_COMMENT=(sed -i '/^# BEGIN LIGHT$/,/^# END LIGHT$/ s/^/#/' ~/.config/swaynag/config)
SWAYNAG_LIGHT_UNCOMMENT=(sed -i '/^## BEGIN LIGHT$/,/^## END LIGHT$/ s/^#//' ~/.config/swaynag/config)

usage() {
	printf "Usage: toggle-theme.sh [OPTION]\nOptions:\n  -d     Turn dark mode on\n  -l     Turn light mode on\n  -t     Toggles dark/light mode\n  -q     Query the current mode\n"
}
query() {
	if grep -q '^!! BEGIN DARK$' ~/.Xresources; then
		echo ""
	else
		echo ""
	fi
}
refresh() {
	xrdb ~/.Xresources
	if pgrep -x dunst >/dev/null; then
		killall -q dunst && dunst --config ~/.config/dunst/dunstrc >/dev/null 2>&1 &
	fi
	killall -q pcmanfm
	/usr/bin/batcat cache --build >/dev/null
	if [[ "$(wmctrl -m | grep Name | awk '{print $2}')" == "LG3D" ]]; then
		bspc wm -r >/dev/null 2>&1
	fi
	if [[ "$(wmctrl -m | grep Name | awk '{print $2}')" == "wlroots" ]]; then
        pkill waybar && swaymsg reload
	fi
}
dark() {
	if grep -q '^!! BEGIN DARK$' ~/.Xresources; then
		"${DUNST_DARK_UNCOMMENT[@]}"
		"${DUNST_LIGHT_COMMENT[@]}"
		"${TMUX_DARK_UNCOMMENT[@]}"
		"${TMUX_LIGHT_COMMENT[@]}"
		"${BAT_DARK_UNCOMMENT[@]}"
		"${BAT_LIGHT_COMMENT[@]}"
		"${X_DARK_UNCOMMENT[@]}"
		"${X_LIGHT_COMMENT[@]}"
		"${GTK3_DARK[@]}"
		"${GTK2_DARK[@]}"
		"${QT5_DARK[@]}"
		"${QT5_ICON_DARK[@]}"
		"${ROFI_DARK[@]}"
		"${NVIM_DARK[@]}"
		"${ALACRITTY_DARK[@]}"
		"${SWAY_DARK_UNCOMMENT[@]}"
		"${SWAY_LIGHT_COMMENT[@]}"
		"${SWAYNAG_DARK_UNCOMMENT[@]}"
		"${SWAYNAG_LIGHT_COMMENT[@]}"
		refresh
	fi
	echo ""
}
light() {
	if grep -q '^!! BEGIN LIGHT$' ~/.Xresources; then
		"${DUNST_LIGHT_UNCOMMENT[@]}"
		"${DUNST_DARK_COMMENT[@]}"
		"${TMUX_LIGHT_UNCOMMENT[@]}"
		"${TMUX_DARK_COMMENT[@]}"
		"${BAT_LIGHT_UNCOMMENT[@]}"
		"${BAT_DARK_COMMENT[@]}"
		"${X_LIGHT_UNCOMMENT[@]}"
		"${X_DARK_COMMENT[@]}"
		"${GTK3_LIGHT[@]}"
		"${GTK2_LIGHT[@]}"
		"${QT5_LIGHT[@]}"
		"${QT5_ICON_LIGHT[@]}"
		"${ROFI_LIGHT[@]}"
		"${NVIM_LIGHT[@]}"
		"${ALACRITTY_LIGHT[@]}"
		"${SWAY_LIGHT_UNCOMMENT[@]}"
		"${SWAY_DARK_COMMENT[@]}"
		"${SWAYNAG_LIGHT_UNCOMMENT[@]}"
		"${SWAYNAG_DARK_COMMENT[@]}"
		refresh
	fi
	echo ""
}
toggle() {
	if grep -q '^!! BEGIN DARK$' ~/.Xresources; then
		dark
	else
		light
	fi
}

while getopts "tldqh" o; do case "${o}" in
	h) usage && exit 1 ;;
	t) toggle ;;
	l) light ;;
	d) dark ;;
	q) query ;;
	*) printf "Invalid option: -%s\\n  -h: To show help\\n" "$OPTARG" && exit 1 ;;
	esac done
