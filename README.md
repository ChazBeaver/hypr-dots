# hypr-dotfiles

Wayland desktop environment dotfiles for Hyprland and supporting apps like Waybar, Kitty, WezTerm, and more.

## 📂 Structure

- `active/` – Config folders that are currently stowed into `~/.config`
- `inactive/` – Alternative or archived configs not currently in use
- `justfile` – Justfile commands to manage dotfiles with stow

## 🧰 Requirements

- [just](https://github.com/casey/just)
- [GNU stow](https://www.gnu.org/software/stow/)

## 🧩 Active Configs

These are expected to be in `active/`, and will be symlinked into `~/.config`:

- `hypr/`
- `waybar/`
- `wezterm/`
- `kitty/`
- `rofi/`
- `swaync/`
- `wallust/`
- `qt5ct/`, `qt6ct/`
- `btop/`, `cava/`, `fastfetch/`, `mpv/`

## 🚀 Usage

```bash
just stow      # Symlink all active dotfiles into ~/.config
just unstow    # Remove the stowed symlinks
just backup    # Save current configs to ~/backups
just restore   # Restore backed-up configs from ~/backups
```

🧪 Notes

 - Only contents in active/ are managed by just stow.

 - Keep unused or experimental configs in inactive/.
