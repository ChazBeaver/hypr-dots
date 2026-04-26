# Hyprdots

A modular dotfiles system for managing Hyprland and Omarchy configurations on Arch Linux.

Pure Bash — no dependencies beyond what Omarchy provides. Symlinks configs cleanly into `~/.config/`, installs declared packages, and keeps everything verifiable with a built-in doctor.

---

## 📦 What's Inside

| Scope | What it manages |
|:------|:----------------|
| `active/omarchy/` | Hyprland, Hyprlock, Hypridle, Hyprsunset, Waybar, Walker, Mako, Ghostty, Alacritty, IMV, font config, Omarchy themes and shaders |
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

`bootstrap.sh` runs in order:
1. **Backup** — renames any conflicting real `~/.config` entries to `.bak`
2. **Packages** — installs declared packages via `pacman` / `yay`
3. **Sync** — symlinks all configs and bin scripts into place

### After a git pull

```bash
./sync.sh
```

Idempotent — safe to run as many times as you like.

---

## 🗂 Backup Before Sync

```bash
./backup.sh
```

Renames any real (non-symlink) `~/.config` entries that sync would replace, appending `.bak`. Run this manually before your first sync on a machine with existing configs.

---

## 🔍 Diagnostics

```bash
./doctor.sh
```

Runs two checks:

- **`doctor/symlinks.sh`** — verifies every symlink and `~/.local/bin/` entry exists and points correctly. Aether shader symlinks that point to missing external paths are reported as info rather than errors — these are environment issues, not sync drift.
- **`doctor/packages.sh`** — compares installed packages against `packages/linux/core.sh`, filtering out Omarchy base packages, arch-base essentials, and sibling repo (appdots) declarations to avoid false positives.

Exit code is non-zero if drift is detected. Run `./sync.sh` to fix symlink drift.

---

## 🔧 How It Works

### Scopes

Each `active/<scope>/` directory mirrors into `~/.config/`:

| Path in repo | Symlinked to |
|:-------------|:-------------|
| `active/omarchy/.config/<entry>` | `~/.config/<entry>` |
| `active/shared/.config/<entry>` | `~/.config/<entry>` |

`sync.sh` processes `omarchy/` first, then `shared/`.

### bin/

Scripts in `bin/` are symlinked into `~/.local/bin/` with `.sh` stripped from the name, making them available as bare commands:

| Path | Symlinked as |
|:-----|:------------|
| `bin/shared/<script>.sh` | `~/.local/bin/<script>` |
| `bin/linux/<script>.sh` | `~/.local/bin/<script>` |

**Current bin scripts:**

| Script | Command | Purpose |
|:-------|:--------|:--------|
| `bin/linux/monitor-brightness.sh` | `monitor-brightness` | Control external monitor brightness via DDC/CI (`up`, `down`, `set`) |
| `bin/linux/webcam-launch.sh` | `webcam-launch` | Launch webcam |

---

## 🔧 Environment

`sync.sh` writes `HYPR_DOTS_DIR` and an `alias hyprdots` to `~/.dotfiles-env.sh`. This file is shared with appdots so both repos can filter each other's package declarations from drift reports.

Make sure it's sourced in your shell rc:

```bash
# ~/.zshrc or ~/.bashrc
[ -f ~/.dotfiles-env.sh ] && source ~/.dotfiles-env.sh
```

The `hyprdots` alias drops you into the repo directory from anywhere.

---

## 📁 Repo Layout

```
hyprdots/
├── active/
│   ├── omarchy/         # Omarchy/Hyprland configs → ~/.config/
│   └── shared/          # Shared configs           → ~/.config/
├── bin/
│   ├── shared/          # Cross-platform scripts   → ~/.local/bin/
│   └── linux/           # Linux scripts            → ~/.local/bin/
├── doctor/
│   ├── packages.sh      # Package drift check
│   └── symlinks.sh      # Symlink drift check
├── lib/
│   ├── backup.sh        # Backup helpers
│   ├── detect.sh        # OS detection + assert_linux
│   ├── link.sh          # Symlink creation logic
│   └── log.sh           # Emoji logging helpers
├── packages/
│   └── linux/core.sh    # Declared pacman / AUR packages
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

`hyprdots` and `appdots` are sibling repos. Both write their install path to `~/.dotfiles-env.sh` so each repo's `doctor/packages.sh` can filter out the other's declared packages from drift reports, preventing false positives.

Both repos share the same `lib/` architecture and shell conventions. Appdots handles application configs (Neovim, Zsh, Git, etc.) across Linux and macOS. Hyprdots handles Hyprland and Omarchy configs on Linux only.

---

## 📜 License

MIT License
