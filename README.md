# Hyprdots

A modular dotfiles system for managing Hyprland and Omarchy configurations on Arch Linux.

Uses pure Bash to symlink configs cleanly into `~/.config/`. No dependencies beyond what Omarchy provides.

---

## 📦 What's Inside

| Scope | What it manages |
|:------|:----------------|
| `active/omarchy/` | Hyprland, Hyprlock, Hypridle, Waybar, Walker, Mako, Ghostty, Alacritty, IMV, font config, Omarchy themes |
| `active/shared/` | Cava, KeePassXC |

All entries under each scope's `.config/` are symlinked 1:1 into `~/.config/`.

---

## 🚀 Quick Start

### Fresh machine (first time)

```bash
git clone <repo-url> ~/hyprdots
cd ~/hyprdots
./bootstrap.sh
```

`bootstrap.sh` will:
1. Back up any existing `~/.config` entries that would be replaced
2. Install declared packages via `pacman` / `yay`
3. Symlink all configs

### After a git pull

```bash
./sync.sh
```

Idempotent — safe to run as many times as you like.

---

## 🔍 Diagnostics

```bash
./doctor.sh
```

Runs two checks:

- **symlinks.sh** — verifies every symlink exists and points correctly
- **packages.sh** — compares installed packages against `packages/linux/core.sh`

Exit code is non-zero if drift is detected. External targets (e.g. aether shader symlinks requiring the `aether` package) are reported as info, not errors.

---

## 🗂 Backup Before Sync

```bash
./backup.sh
```

Renames any real (non-symlink) `~/.config` entries that sync would replace by appending `.bak`. Run this manually before your first sync on a machine with existing configs.

---

## 🔧 Environment

`sync.sh` writes `HYPR_DOTS_DIR` and an `alias hyprdots` to `~/.dotfiles-env.sh`. Source this in your shell rc if you want the alias available everywhere:

```bash
# in ~/.zshrc or ~/.bashrc
[ -f ~/.dotfiles-env.sh ] && source ~/.dotfiles-env.sh
```

This file is also read by `appdots/doctor/packages.sh` so it can filter hyprdots' package declarations from its own drift report, and vice versa.

---

## 📁 Repo Layout

```
hyprdots/
├── active/
│   ├── omarchy/         # Omarchy/Hyprland configs → ~/.config/
│   └── shared/          # Shared configs          → ~/.config/
├── doctor/
│   ├── packages.sh      # Package drift check
│   └── symlinks.sh      # Symlink drift check
├── lib/
│   ├── backup.sh        # Backup helpers
│   ├── detect.sh        # OS detection
│   ├── link.sh          # Symlink creation logic
│   └── log.sh           # Emoji logging helpers
├── packages/
│   └── linux/
│       └── core.sh      # Declared pacman / AUR packages
├── scripts/
│   └── misc/
│       └── check-drift.sh
├── backup.sh            # Back up before sync
├── bootstrap.sh         # Cold-boot: backup + packages + sync
├── doctor.sh            # Run all diagnostics
└── sync.sh              # Symlink sync (run after git pull)
```

---

## 🔄 Relationship with Appdots

`hyprdots` and `appdots` are sibling repos. They share `~/.dotfiles-env.sh` to advertise their locations to each other's `doctor/packages.sh` scripts, so package drift reports correctly exclude the other repo's declared packages.

Both repos use the same `lib/` architecture and shell conventions.
