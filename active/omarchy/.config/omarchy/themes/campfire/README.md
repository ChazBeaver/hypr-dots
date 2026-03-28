# Campfire for Omarchy

Campfire is an Omarchy theme package built to coordinate the wider desktop theme with the Neovim theme **`campfire`**.

This repo is the Omarchy-side theme bundle. It provides the files Omarchy uses for desktop and application styling, while Neovim itself is styled by the separate Neovim colorscheme named `campfire`.

## Relationship to the Neovim theme

This Omarchy theme is designed to pair with the Neovim theme:

- **Neovim theme name:** `campfire`
- **Omarchy theme repo:** `omarchy-campfire-theme`

The Omarchy theme and the Neovim theme are meant to visually match. In practice, this means:

- Omarchy handles the broader desktop/app theme files
- Neovim loads the `campfire` colorscheme
- both share the same palette direction so the full environment feels consistent

## What this repo contains

Typical files in this Omarchy theme bundle include:

- `colors.toml`
- `colors.css`
- `btop.theme`
- `cava_theme`
- `chromium.theme`
- `mako.ini`
- `walker.css`
- `warp.yaml`
- `palette.json`
- wallpapers / previews / supporting assets

## How it works with Omarchy

Omarchy reads the theme files in this repo to style supported applications and desktop components.

Neovim is intended to load the separate `campfire` theme so that the editor and the Omarchy theme remain aligned.

## Naming convention

- **Omarchy repo:** `omarchy-campfire-theme`
- **Neovim theme:** `campfire`

## Goal

Campfire is meant to provide a consistent look across Omarchy, terminal tools, and Neovim.
