set shell := ["zsh", "-cu"]

default:
	@just --summary

stow:
	cd active && \
	stow -t $HOME/.config \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd

unstow:
	cd active && \
	stow -D -t $HOME/.config \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd

check:
	ls -l ~/.config/hypr/hyprland.conf
	ls -l ~/.config/waybar/config
	ls -l ~/.config/rofi/config.rasi
