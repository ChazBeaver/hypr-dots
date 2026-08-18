# Hyprdots

Hyprdots is the small personal layer applied after a fresh Omarchy Quattro
installation. It persists intentional Hyprland behavior, a custom Quattro lock
and idle experience, and a curated list of non-default packages without taking
ownership of application configs managed by
[appdots](../appdots/README.md).

## Fresh Omarchy Quattro build

Clone the repository anywhere under your home directory, then run:

```bash
./bootstrap.sh
```

Bootstrap is the one-time convergence command. It verifies Quattro, backs up
conflicting paths owned by this repository, installs declared packages, links
configuration, reloads active services when possible, and runs diagnostics.

After pulling future changes, apply them without sudo or package work:

```bash
./sync.sh
```

Run read-only diagnostics at any time with:

```bash
./doctor.sh
```

## Environment

`bootstrap.sh` creates or repairs `HYPR_DOTS_DIR` and the `hyprdots` alias in
`~/.dotfiles-env.sh` before installation begins. `sync.sh` converges the same
entries on later runs, including when the repository has moved.

The shared environment file is sourced by the appdots-managed shell startup.
After opening a new shell (or sourcing `~/.dotfiles-env.sh`), running
`hyprdots` changes the working directory to `$HYPR_DOTS_DIR` from anywhere.

## Ownership

The exact source-to-target contract is [`config/links.tsv`](config/links.tsv).
Hyprdots manages only:

- Personal Hyprland Lua bindings, opacity, privacy, and square corners.
- Hyprsunset and Hyprland portal configuration, which still use `.conf` files.
- The default Omarchy bar layout with an AM/PM clock, a 14px Omarchy Shell
  font base, plus the `chaz.lock` / `chaz.idle` plugins and their idle settings.
- The `hypr-opacity-cycle` helper.

It deliberately does not manage Ghostty, Neovim, Zsh, Git, Yazi, Starship,
KeePassXC settings, browser profiles, themes, Waybar, UWSM, Alacritty, or broad
Omarchy configuration. Appdots-owned and other foreign links are never
replaced.

## Personal packages

Repository packages are one-per-line in:

- `packages/linux/pacman.txt` for packages available through configured Arch or
  Omarchy repositories.
- `packages/linux/aur.txt` for packages available only from the AUR.

Add package names, not versions. `bootstrap.sh` uses `omarchy pkg add` and
`omarchy pkg aur add`, so installation is idempotent and follows Quattro's
package tooling. Packages already owned by Quattro or appdots must not be
duplicated here.

The current personal set includes Terraform, 1Password and its CLI, GitHub CLI,
Signal, Spotify, Typora, Rust, fwupd, and KeePassXC. KeePassXC is deliberately
also listed by appdots so either repository's bootstrap can install the app;
neither repository persists its vault or sensitive settings.

## Personal behavior

- `SUPER+BACKSPACE` cycles transparent, blur, and opaque modes. The selected
  mode is stored in `~/.local/state/hyprdots/opacity-mode` and survives reloads.
- The personal lock screen uses Quattro's PAM/fingerprint service with a blurred
  wallpaper, large clock, date, weather, and lower password field.
- Idle locking occurs after 30 minutes and suspend after 45 minutes. Quattro's
  stay-awake toggle suppresses both.
- Monitor scaling and input behavior inherit portable Quattro defaults.

## After an Omarchy upgrade

Run `./sync.sh` and `./doctor.sh`. The two plugin `UPSTREAM` files record the
Omarchy version they were cloned from; doctor warns when the installed version
has changed. Rebase the clones against the matching directories under
`/usr/share/omarchy/shell/plugins/`, never by editing packaged files directly.
Doctor also requires the repo-managed bar to contain exactly the widgets from
the installed Quattro default and retain the intentional AM/PM clock. Widget
reordering and bar-edge changes remain allowed, while a partial or stale widget
set fails visibly instead of silently replacing the default bar.

## Privacy boundary

Never commit vaults, KeePassXC configuration, KeeShare keys, browser profiles or
bookmarks, account tokens, SSH keys, Wi-Fi profiles, weather locations, or
machine runtime state. Package names and non-secret desktop preferences are
appropriate to persist.
