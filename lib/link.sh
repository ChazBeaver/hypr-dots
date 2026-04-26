#!/usr/bin/env bash
# hyprdots/lib/link.sh
# Symlink creation logic. Source this; do not execute.
# Depends on: lib/log.sh
#
# hyprdots manages ~/.config/* entries and bin/ scripts.
# Scopes: active/omarchy/.config  active/shared/.config
#         bin/shared/             bin/linux/

# link_item SOURCE TARGET
# Create a symlink at TARGET pointing to SOURCE.
# Replaces stale symlinks or real files. Never touches protected paths.
link_item() {
  local source="$1"
  local target="$2"

  # Already linked correctly? No-op.
  if [ -L "$target" ] && [ "$(readlink "$target" 2>/dev/null || true)" = "$source" ]; then
    log_ok "Already linked: $target"
    return 0
  fi

  # Exists but wrong symlink? Remove and relink.
  if [ -L "$target" ]; then
    rm -f "$target"
    log_replace "Replacing symlink: $target"
  elif [ -e "$target" ]; then
    rm -rf "$target"
    log_clean "Removed existing file/dir: $target"
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"
  log_link "$source → $target"
}

# install_config_scope CONFIG_PATH
# 1:1 mirror: .config/<entry> -> ~/.config/<entry>
install_config_scope() {
  local config_path="$1"
  [ -d "$config_path" ] || return 0

  log_config "Installing .config from: $config_path"
  find "$config_path" -mindepth 1 -maxdepth 1 | while read -r item; do
    local name
    name="$(basename "$item")"
    link_item "$item" "$HOME/.config/$name"
  done
}

# install_bin_scope BIN_DIR OS
# Symlinks bin/shared/* -> ~/.local/bin/<n>   (cross-platform)
#          bin/<OS>/*   -> ~/.local/bin/<n>   (OS-specific)
# Strips trailing .sh from the link name so scripts run as bare commands.
install_bin_scope() {
  local bin_dir="$1"
  local os="$2"
  [ -d "$bin_dir" ] || return 0

  mkdir -p "$HOME/.local/bin"
  log_sync "Syncing bin into ~/.local/bin"

  local -a files=()

  # Cross-platform scripts under bin/shared/
  if [ -d "$bin_dir/shared" ]; then
    while IFS= read -r f; do
      files+=("$f")
    done < <(find "$bin_dir/shared" -mindepth 1 -maxdepth 1 -type f | sort)
  fi

  # OS-specific scripts under bin/<os>/
  if [ -d "$bin_dir/$os" ]; then
    while IFS= read -r f; do
      files+=("$f")
    done < <(find "$bin_dir/$os" -mindepth 1 -maxdepth 1 -type f | sort)
  fi

  for src in "${files[@]}"; do
    local name
    name="$(basename "$src")"
    name="${name%.sh}"
    chmod +x "$src"
    link_item "$src" "$HOME/.local/bin/$name"
  done
}

# install_scope SCOPE_DIR
# Entry point. Dispatches .config scope for a given active/<layer>/ directory.
install_scope() {
  local scope_dir="$1"
  [ -d "$scope_dir" ] || return 0

  log_step "Processing scope: $scope_dir"
  install_config_scope "$scope_dir/.config"
}
