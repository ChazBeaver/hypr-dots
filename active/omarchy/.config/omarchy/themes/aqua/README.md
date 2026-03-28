# Aqua for Omarchy

Aqua is an Omarchy theme package built to coordinate the wider desktop theme with the Neovim theme **`aqua`**.

This repo is the Omarchy-side theme bundle. It provides the files Omarchy uses for desktop and application styling, while Neovim itself is styled by the separate Neovim colorscheme named `aqua`.

## Relationship to the Neovim theme

This Omarchy theme is designed to pair with the Neovim theme:

- **Neovim theme name:** `aqua`
- **Omarchy theme repo:** `omarchy-aqua-theme`

The Omarchy theme and the Neovim theme are meant to visually match. In practice, this means:

- Omarchy handles the broader desktop/app theme files
- Neovim loads the `aqua` colorscheme
- both share the same palette direction so the full environment feels consistent

## What this repo contains

Typical files in this Omarchy theme bundle include:

- `colors.toml` — source palette used across the theme
- `colors.css` — shared CSS color definitions
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

Neovim is not styled directly by this Omarchy repo alone. Instead, the Omarchy theme is intended to be used alongside the Neovim theme `aqua`, so the editor matches the rest of the system.

## Naming convention

This repo is named after the Omarchy theme package:

- `omarchy-aqua-theme`

The Neovim theme it is built around is:

- `aqua`

That separation is intentional:

- **Omarchy theme repo** = full desktop/app bundle
- **Neovim theme** = editor colorscheme

## Goal

The goal of this theme is to make Omarchy and Neovim feel like one unified environment rather than two separate themes.
