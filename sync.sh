#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")" &>/dev/null && pwd)"
LINKS_MANIFEST="$REPO_DIR/config/links.tsv"
RETIRED_LINKS="$REPO_DIR/config/retired-links.txt"
ENV_FILE="$HOME/.dotfiles-env.sh"

source "$REPO_DIR/lib/log.sh"
source "$REPO_DIR/lib/detect.sh"
source "$REPO_DIR/lib/manifest.sh"
source "$REPO_DIR/lib/link.sh"

assert_linux

if [[ ! -d /usr/share/omarchy || ! -f /usr/share/omarchy/default/hypr/bootstrap.lua ]]; then
  log_err "Omarchy Quattro with Lua Hyprland configuration is required"
  exit 1
fi

touch "$ENV_FILE"
if grep -q '^export HYPR_DOTS_DIR=' "$ENV_FILE"; then
  sed -i "s|^export HYPR_DOTS_DIR=.*|export HYPR_DOTS_DIR=\"$REPO_DIR\"|" "$ENV_FILE"
else
  printf 'export HYPR_DOTS_DIR="%s"\n' "$REPO_DIR" >> "$ENV_FILE"
fi
grep -q '^alias hyprdots=' "$ENV_FILE" || printf '%s\n' 'alias hyprdots="cd $HYPR_DOTS_DIR"' >> "$ENV_FILE"

log_step "Installing explicitly owned configuration"
install_manifest

if [[ "${HYPRDOTS_OFFLINE:-0}" == "1" ]]; then
  log_info "Offline mode: service reloads skipped"
elif omarchy-shell shell ping >/dev/null 2>&1; then
  omarchy-shell shell rescanPlugins >/dev/null
  omarchy-shell shell reloadConfig >/dev/null
  log_ok "Reloaded Omarchy shell configuration"
else
  log_info "Omarchy shell is not running; plugins will load at next login"
fi

if [[ "${HYPRDOTS_OFFLINE:-0}" == "1" ]]; then
  :
elif hyprctl instances >/dev/null 2>&1; then
  hyprctl reload >/dev/null
  log_ok "Reloaded Hyprland"
else
  log_info "Hyprland is not running; configuration will load at next login"
fi

log_ok "Hyprdots sync complete"
