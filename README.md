# Hypr-Dots

A modular, future-proof dotfiles system for managing Hyprland and Wayland desktop environment configurations.

Hypr-Dots uses a pure Bash install script to cleanly symlink configs into your `$HOME/.config/` directory — no dependencies, no extra tools required.

---

## 📦 What's Included

| Application / Tool | Config Location |
|:-------------------|:----------------|
| AGS                 | `.config/ags/` |
| Autostart           | `.config/autostart/` |
| Btop                | `.config/btop/` |
| Cava                | `.config/cava/` |
| Fastfetch           | `.config/fastfetch/` |
| Fontconfig          | `.config/fontconfig/` |
| Hyprland            | `.config/hypr/` |
| Kitty               | `.config/kitty/` |
| Kvantum             | `.config/Kvantum/` |
| Mousepad            | `.config/Mousepad/` |
| MPV                 | `.config/mpv/` |
| NWG-Look            | `.config/nwg-look/` |
| Qt5ct               | `.config/qt5ct/` |
| Qt6ct               | `.config/qt6ct/` |
| Rofi                | `.config/rofi/` |
| Swappy              | `.config/swappy/` |
| Swaync              | `.config/swaync/` |
| Thunar              | `.config/Thunar/` |
| Wallust             | `.config/wallust/` |
| Waybar              | `.config/waybar/` |
| WezTerm             | `.config/wezterm/` |
| Wlogout             | `.config/wlogout/` |
| XFCE4               | `.config/xfce4/` |
| Xsettingsd          | `.config/xsettingsd/` |

---

## 🚀 Install

The install script will:

- Set the `HYPR_DOTS_DIR` environment variable (saved in `~/.dotfiles-env.sh`).
- Symlink configs from `active/.config/` into `$HOME/.config/`, preserving app structure.
- Skip anything already correctly linked.

---

## 🛠 How It Works

- **active/.config/** — Top-level configs and folders for Hyprland and related apps.
- **inactive/** — Configs stored for later, but not installed.

Move files between `active/.config/` and `inactive/` as needed, then re-run `install.sh`.

The script only links top-level folders and files inside `.config/` — no deep recursion.

---

## ✨ Coming Soon

- Optional backups for conflicting configs.
- Install summary report (e.g., number of links created, skipped).
- Bootstrap integration for multi-repo setups (e.g., app-dots + hypr-dots).

---

## 📜 License

MIT License
