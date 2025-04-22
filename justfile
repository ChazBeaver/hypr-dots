set shell := ["zsh", "-cu"]

default:
	@just --summary

install:
	@cd active && \
	for dir in \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd; do \
		ln -sfn "$PWD/$dir" "$HOME/.config/$dir"; \
		echo "→ linked $PWD/$dir to ~/.config/$dir"; \
	done

uninstall:
	@for dir in \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd; do \
		rm -rf "$HOME/.config/$dir" && echo "✘ removed ~/.config/$dir"; \
	done

check:
	@for dir in \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd; do \
		test -L "$HOME/.config/$dir" && echo "✔ $dir is symlinked" || echo "✘ $dir is NOT symlinked"; \
	done

status:
	@for dir in \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd; do \
		test -e "$HOME/.config/$dir" && echo "✔ $dir exists" || echo "✘ $dir is missing"; \
	done
