#!/usr/bin/env bash
# hyprdots/lib/backup.sh
# Backup helpers. Source this; do not execute.
# Depends on: lib/log.sh
#
# hyprdots manages only ~/.config/* entries (no HOME bucket, no library).
# Scopes: active/omarchy/.config  active/shared/.config

backup_item() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    if [ -e "$target.bak" ] || [ -L "$target.bak" ]; then
      log_warn "Backup already exists: $target.bak (skipped)"
    else
      mv "$target" "$target.bak"
      log_backup "$target → $target.bak"
    fi
  fi
}

backup_config_scope() {
  local layer_dir="$1"
  local cfg="$layer_dir/.config"
  [ -d "$cfg" ] || return 0

  log_config "Scanning .config: $cfg"
  find "$cfg" -mindepth 1 -maxdepth 1 | while read -r entry; do
    backup_item "$HOME/.config/$(basename "$entry")"
  done
}

backup_scope() {
  local scope_dir="$1"
  [ -d "$scope_dir" ] || return 0
  log_step "Scanning: $scope_dir"
  backup_config_scope "$scope_dir"
}
