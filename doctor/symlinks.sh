#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# hyprdots/doctor/symlinks.sh
# Verify every symlink sync.sh would create actually exists and points correctly.
# Read-only. Distinguishes:
#   - DRIFT (error)   : user symlink missing, wrong target, or replaced by a real file
#   - EXTERNAL (info) : user symlink correctly points at the repo source, but the
#                       repo source itself is a symlink to a missing external path
#                       (e.g. /usr/share/aether/shaders/foo.glsl when aether isn't
#                       installed). This is an environment issue, not sync drift.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")" &>/dev/null && pwd)"
HYPRDOTS_DIR="$(cd -- "$SCRIPT_DIR/.." &>/dev/null && pwd)"
ACTIVE_DIR="$HYPRDOTS_DIR/active"

# shellcheck source=../lib/log.sh
source "$HYPRDOTS_DIR/lib/log.sh"
# shellcheck source=../lib/detect.sh
source "$HYPRDOTS_DIR/lib/detect.sh"

assert_linux

DRIFT=0
EXTERNAL=0

is_internal_path() {
  case "$1" in
    "$HYPRDOTS_DIR"/*) return 0 ;;
    *) return 1 ;;
  esac
}

check_link() {
  local source="$1"   # path inside the repo
  local target="$2"   # path in the user's home

  if [ ! -L "$target" ]; then
    if [ -e "$target" ]; then
      log_err "Not a symlink (real file): $target"
    else
      log_err "Missing: $target (should link to $source)"
    fi
    DRIFT=1
    return
  fi

  local actual
  actual="$(readlink "$target")"
  if [ "$actual" != "$source" ]; then
    log_err "Wrong target: $target → $actual (expected $source)"
    DRIFT=1
    return
  fi

  # User symlink looks right. Now check whether the chain ultimately resolves.
  if [ ! -e "$target" ]; then
    if [ -L "$source" ]; then
      local source_target
      source_target="$(readlink "$source")"
      if ! is_internal_path "$source_target"; then
        log_info "External target unresolved: $target → $source → $source_target (target missing on this system)"
        EXTERNAL=1
        return
      fi
    fi
    log_err "Dangling symlink: $target → $source (repo source missing)"
    DRIFT=1
  fi
}

check_home_scope() {
  local home_path="$1"
  [ -d "$home_path" ] || return 0

  find "$home_path" -mindepth 1 -maxdepth 1 | while read -r entry; do
    local base
    base="$(basename "$entry")"
    if [ -d "$entry" ] && [[ "$base" != .* ]]; then
      find "$entry" -mindepth 1 -maxdepth 1 | while read -r item; do
        check_link "$item" "$HOME/$(basename "$item")"
      done
    else
      check_link "$entry" "$HOME/$base"
    fi
  done
}

check_config_scope() {
  local cfg="$1"
  [ -d "$cfg" ] || return 0

  find "$cfg" -mindepth 1 -maxdepth 1 | while read -r item; do
    check_link "$item" "$HOME/.config/$(basename "$item")"
  done
}

check_bin_scope() {
  local bin_dir="$1"
  [ -d "$bin_dir" ] || return 0

  find "$bin_dir" -mindepth 1 -maxdepth 1 -type f | sort | while read -r item; do
    local name
    name="$(basename "$item")"
    name="${name%.sh}"
    check_link "$item" "$HOME/.local/bin/$name"
  done
}

check_scope() {
  local scope="$1"
  [ -d "$scope" ] || return 0

  log_step "Checking: $scope"
  check_home_scope   "$scope/HOME"
  check_config_scope "$scope/.config"
}

echo
log_info "Symlink drift check"
echo

check_scope "$ACTIVE_DIR/omarchy"
check_scope "$ACTIVE_DIR/shared"

log_step "Checking: $HYPRDOTS_DIR/bin"
check_bin_scope "$HYPRDOTS_DIR/bin"

echo
if [ "$DRIFT" -eq 0 ] && [ "$EXTERNAL" -eq 0 ]; then
  log_ok "No symlink drift detected."
  exit 0
elif [ "$DRIFT" -eq 0 ]; then
  log_ok "No sync drift. (Some external targets unresolved — env issue, not sync.)"
  exit 0
else
  log_warn "Symlink drift detected. Run ./sync.sh to fix."
  exit 1
fi
