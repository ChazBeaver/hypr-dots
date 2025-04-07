# hypr-dotfiles

Wayland and Hyprland configuration files including Waybar, Rofi, SwayNC, Wallust, and other UI components specific to the Hyprland environment.

## 📂 Structure

- `active/` – Dotfiles currently in use, symlinked via `stow`
- `justfile` – Task runner for managing and verifying symlinks

## 🧰 Requirements

- [just](https://github.com/casey/just)
- [GNU stow](https://www.gnu.org/software/stow/)

## 🖥 Managed Configs

These live in `~/.config/` and are expected to be symlinked from `active/`:

- `hypr/`
- `waybar/`
- `rofi/`
- `swaync/`
- `wallust/`
- `wezterm/`, `kitty/`, `mpv/`, etc.
- Support apps like `qt5ct/`, `qt6ct/`, `fastfetch/`, `swappy/`, and more

## 🚀 Usage

```bash
just stow      # Symlink configs from active/ into ~/.config
just unstow    # Remove symlinks
just check     # Confirm everything is properly symlinked
just status    # Check that the expected directories exist
```

## 🧪 Notes

- This project is tightly coupled to Wayland and Hyprland setups.

- These dotfiles should not be reused in non-Wayland environments.
