# hypr-dotfiles

Wayland desktop environment dotfiles for Hyprland and supporting applications.  
Designed to be reproducible, stowable, and extensible for Hyprland-based setups.

## 📂 Structure

- `active/` – Config folders that are currently stowed into `~/.config`
- `inactive/` – Alternative or archived configs not currently in use
- `justfile` – Task automation using [just](https://github.com/casey/just) and [GNU stow](https://www.gnu.org/software/stow/)

## 🧰 Requirements

- [`just`](https://github.com/casey/just) – Simple command runner
- [`stow`](https://www.gnu.org/software/stow/) – Symlink farm manager for dotfiles

## 🧩 Active Configs

These are the folders currently managed by `just stow`, each symlinked into `~/.config`:

- `hypr/`, `waybar/`, `rofi/`, `swaync/`, `wallust/`
- `wezterm/`, `kitty/`, `mpv/`, `qt5ct/`, `qt6ct/`
- `btop/`, `cava/`, `fastfetch/`
- `mono/`, `KDE_backup/`, `KeePass/`, `Kvantum/`, `Mousepad/`, `Thunar/`
- `ags/`, `autostart/`, `dconf/`, `environment.d/`, `eog/`, `fontconfig/`
- `gtk-3.0/`, `gtk-4.0/`, `home-manager/`, `ibus/`, `libaccounts-glib/`
- `nwg-look/`, `pulse/`, `session/`, `swappy/`, `wlogout/`, `xfce4/`, `xsettingsd/`

🛑 `nvim-backup-back-up_0915_1005/` is intentionally excluded.

## 🚀 Usage

```bash
just stow      # Symlink all active dotfiles into ~/.config
just unstow    # Remove all active symlinks
just backup    # Save current configs into ~/backups
just restore   # Restore configs from ~/backups into ~/.config

## 🧪 Notes

  - Only folders in active/ are included in the stow/backup/restore process.

  - Use inactive/ to archive unused or experimental configs.

  - You can extend the justfile with custom recipes as needed (e.g., just edit, just theme, etc.).

## 💾 Backup & Restore

Backups are saved to ~/backups, preserving your real config in case you want to revert changes.
Stowing/unstowing is safe and idempotent — ideal for tracking dotfiles with Git.
