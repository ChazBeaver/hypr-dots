#!/usr/bin/env bash
# Manifest-driven backup helpers. Depends on lib/log.sh and lib/manifest.sh.

BACKUP_STAMP="${BACKUP_STAMP:-$(date +%Y%m%d%H%M%S)}"

backup_manifest_item() {
  local _source="$1" target="$2" backup
  if [[ -e "$target" && ! -L "$target" ]]; then
    backup="$target.hyprdots-backup.$BACKUP_STAMP"
    if [[ -e "$backup" || -L "$backup" ]]; then
      log_err "Backup target already exists: $backup"
      return 1
    fi
    mv "$target" "$backup"
    log_backup "$target -> $backup"
  fi
}

backup_manifest() {
  manifest_each backup_manifest_item
}
