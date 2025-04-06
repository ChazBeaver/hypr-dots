set shell := ["zsh", "-cu"]

default:
	@just --summary

# Stow dotfiles into ~/.config
stow:
	cd active && \
	stow -t $HOME/.config \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd
	# nvim-backup-back-up_0915_1005 is excluded

# Unstow symlinks from ~/.config
unstow:
	cd active && \
	stow -D -t $HOME/.config \
		hypr waybar rofi swaync wallust wezterm kitty mpv qt5ct qt6ct \
		btop cava fastfetch mono KDE_backup KeePass Kvantum Mousepad \
		Thunar ags autostart dconf environment.d eog fontconfig gtk-3.0 gtk-4.0 \
		home-manager ibus libaccounts-glib nwg-look pulse session \
		swappy wlogout xfce4 xsettingsd
	# nvim-backup-back-up_0915_1005 is excluded

# Backup current config files
backup:
	mkdir -p ~/backups
	rsync -a ~/.config/hypr ~/backups/hypr/
	rsync -a ~/.config/waybar ~/backups/waybar/
	rsync -a ~/.config/wezterm ~/backups/wezterm/
	rsync -a ~/.config/kitty ~/backups/kitty/
	rsync -a ~/.config/rofi ~/backups/rofi/
	rsync -a ~/.config/swaync ~/backups/swaync/
	rsync -a ~/.config/wallust ~/backups/wallust/
	rsync -a ~/.config/qt5ct ~/backups/qt5ct/
	rsync -a ~/.config/qt6ct ~/backups/qt6ct/
	rsync -a ~/.config/mpv ~/backups/mpv/
	rsync -a ~/.config/btop ~/backups/btop/
	rsync -a ~/.config/cava ~/backups/cava/
	rsync -a ~/.config/fastfetch ~/backups/fastfetch/
	rsync -a ~/.config/.mono ~/backups/.mono/
	rsync -a ~/.config/KDE_backup ~/backups/KDE_backup/
	rsync -a ~/.config/KeePass ~/backups/KeePass/
	rsync -a ~/.config/Kvantum ~/backups/Kvantum/
	rsync -a ~/.config/Mousepad ~/backups/Mousepad/
	rsync -a ~/.config/Thunar ~/backups/Thunar/
	rsync -a ~/.config/ags ~/backups/ags/
	rsync -a ~/.config/autostart ~/backups/autostart/
	rsync -a ~/.config/dconf ~/backups/dconf/
	rsync -a ~/.config/environment.d ~/backups/environment.d/
	rsync -a ~/.config/eog ~/backups/eog/
	rsync -a ~/.config/fontconfig ~/backups/fontconfig/
	rsync -a ~/.config/gtk-3.0 ~/backups/gtk-3.0/
	rsync -a ~/.config/gtk-4.0 ~/backups/gtk-4.0/
	rsync -a ~/.config/home-manager ~/backups/home-manager/
	rsync -a ~/.config/ibus ~/backups/ibus/
	rsync -a ~/.config/libaccounts-glib ~/backups/libaccounts-glib/
	rsync -a ~/.config/nwg-look ~/backups/nwg-look/
	rsync -a ~/.config/pulse ~/backups/pulse/
	rsync -a ~/.config/session ~/backups/session/
	rsync -a ~/.config/swappy ~/backups/swappy/
	rsync -a ~/.config/wlogout ~/backups/wlogout/
	rsync -a ~/.config/xfce4 ~/backups/xfce4/
	rsync -a ~/.config/xsettingsd ~/backups/xsettingsd/
	# nvim-backup-back-up_0915_1005 is excluded

# Restore backed up config files
restore:
	rsync -a ~/backups/hypr/ ~/.config/hypr/
	rsync -a ~/backups/waybar/ ~/.config/waybar/
	rsync -a ~/backups/wezterm/ ~/.config/wezterm/
	rsync -a ~/backups/kitty/ ~/.config/kitty/
	rsync -a ~/backups/rofi/ ~/.config/rofi/
	rsync -a ~/backups/swaync/ ~/.config/swaync/
	rsync -a ~/backups/wallust/ ~/.config/wallust/
	rsync -a ~/backups/qt5ct/ ~/.config/qt5ct/
	rsync -a ~/backups/qt6ct/ ~/.config/qt6ct/
	rsync -a ~/backups/mpv/ ~/.config/mpv/
	rsync -a ~/backups/btop/ ~/.config/btop/
	rsync -a ~/backups/cava/ ~/.config/cava/
	rsync -a ~/backups/fastfetch/ ~/.config/fastfetch/
	rsync -a ~/backups/.mono/ ~/.config/.mono/
	rsync -a ~/backups/KDE_backup/ ~/.config/KDE_backup/
	rsync -a ~/backups/KeePass/ ~/.config/KeePass/
	rsync -a ~/backups/Kvantum/ ~/.config/Kvantum/
	rsync -a ~/backups/Mousepad/ ~/.config/Mousepad/
	rsync -a ~/backups/Thunar/ ~/.config/Thunar/
	rsync -a ~/backups/ags/ ~/.config/ags/
	rsync -a ~/backups/autostart/ ~/.config/autostart/
	rsync -a ~/backups/dconf/ ~/.config/dconf/
	rsync -a ~/backups/environment.d/ ~/.config/environment.d/
	rsync -a ~/backups/eog/ ~/.config/eog/
	rsync -a ~/backups/fontconfig/ ~/.config/fontconfig/
	rsync -a ~/backups/gtk-3.0/ ~/.config/gtk-3.0/
	rsync -a ~/backups/gtk-4.0/ ~/.config/gtk-4.0/
	rsync -a ~/backups/home-manager/ ~/.config/home-manager/
	rsync -a ~/backups/ibus/ ~/.config/ibus/
	rsync -a ~/backups/libaccounts-glib/ ~/.config/libaccounts-glib/
	rsync -a ~/backups/nwg-look/ ~/.config/nwg-look/
	rsync -a ~/backups/pulse/ ~/.config/pulse/
	rsync -a ~/backups/session/ ~/.config/session/
	rsync -a ~/backups/swappy/ ~/.config/swappy/
	rsync -a ~/backups/wlogout/ ~/.config/wlogout/
	rsync -a ~/backups/xfce4/ ~/.config/xfce4/
	rsync -a ~/backups/xsettingsd/ ~/.config/xsettingsd/
	# nvim-backup-back-up_0915_1005 is excluded
