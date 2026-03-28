# Dark-Lotus for Omarchy

Dark-Lotus is an Omarchy theme package built to coordinate the wider desktop theme with the Neovim theme **`dark-lotus`**.

This repo is the Omarchy-side theme bundle. It provides the files Omarchy uses for desktop and application styling, while Neovim itself is styled by the separate Neovim colorscheme named `dark-lotus`.

## Relationship to the Neovim theme

This Omarchy theme is designed to pair with the Neovim theme:

- **Neovim theme name:** `dark-lotus`
- **Omarchy theme repo:** `omarchy-dark-lotus-theme`

The two are meant to work together:

- Omarchy handles the broader theme system
- Neovim loads `dark-lotus`
- both follow the same palette and visual identity

## What this repo contains

Typical files include:

- `colors.toml`
- `colors.css`
- `btop.theme`
- `cava_theme`
- `chromium.theme`
- `mako.ini`
- `walker.css`
- `warp.yaml`
- `palette.json`

## How it works with Omarchy

Omarchy reads this repo’s theme files for supported desktop and app theming. The editor portion is expected to come from the Neovim colorscheme `dark-lotus`.

## Naming convention

- **Omarchy repo:** `omarchy-dark-lotus-theme`
- **Neovim theme:** `dark-lotus`

## Goal

Dark-Lotus is meant to unify the Omarchy desktop, terminal-facing apps, and Neovim into one consistent theme experience.
