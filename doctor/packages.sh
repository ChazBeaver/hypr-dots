#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# hyprdots/doctor/packages.sh
# Compare installed packages against packages/linux/core.sh.
#
# Filters:
#   - Omarchy base manifest (~/.local/share/omarchy/install/omarchy-base.packages)
#   - Hard-coded arch-base essentials (kernel, firmware, microcode, bootloader, etc.)
#   - Sibling repo: appdots's declared packages, IF appdots exists on this machine
#
# Sibling repo discovery is via the shared env file (~/.dotfiles-env.sh) which
# both repos write to. On a fresh box where appdots isn't checked out yet,
# the sibling filter is silently skipped.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")" &>/dev/null && pwd)"
HYPRDOTS_DIR="$(cd -- "$SCRIPT_DIR/.." &>/dev/null && pwd)"
ENV_FILE="$HOME/.dotfiles-env.sh"

# shellcheck source=../lib/log.sh
source "$HYPRDOTS_DIR/lib/log.sh"
# shellcheck source=../lib/detect.sh
source "$HYPRDOTS_DIR/lib/detect.sh"

assert_linux

# Hardcoded essentials installed by pacstrap or required for any working
# Arch-based system. These don't appear in Omarchy's manifest because Omarchy
# starts from an already-bootstrapped Arch base.
ARCH_ESSENTIALS=(
  base base-devel
  linux linux-firmware
  amd-ucode intel-ucode
  efibootmgr btrfs-progs
  limine limine-mkinitcpio-hook limine-snapper-sync
  snapper
  zram-generator
  pipewire pipewire-alsa pipewire-pulse pipewire-jack
  gst-plugin-pipewire libpulse
  sof-firmware
  webkit2gtk webkit2gtk-4.1
  crypto++
  git
  omarchy-keyring
)

extract_packages_from_script() {
  local script="$1"
  [ -f "$script" ] || return 0
  awk '
    /^PACMAN_PKGS=\(/ { in_list = 1; next }
    /^AUR_PKGS=\(/    { in_list = 1; next }
    /^\)/             { in_list = 0; next }
    in_list {
      sub(/#.*/, "")
      gsub(/[[:space:]]/, "")
      if (length($0) > 0) print $0
    }
  ' "$script" | sort -u
}

# Read the Omarchy manifest: one package per line, # comments, blank lines.
# Strip whitespace per-line (NOT all whitespace globally — that would collapse
# the file into one mega-string).
extract_omarchy_base() {
  local file="$1"
  [ -f "$file" ] || return 0
  awk '
    {
      gsub(/\r$/, "")          # strip CR if present (CRLF tolerance)
      sub(/#.*/, "")           # strip inline comments
      gsub(/^[[:space:]]+|[[:space:]]+$/, "")  # trim outer whitespace
      if (length($0) > 0) print $0
    }
  ' "$file" | sort -u
}

resolve_sibling_dir() {
  if [ -r "$ENV_FILE" ]; then
    # shellcheck disable=SC1090
    source "$ENV_FILE" 2>/dev/null || true
  fi
  if [ -n "${APP_DOTS_DIR:-}" ] && [ -d "$APP_DOTS_DIR" ]; then
    echo "$APP_DOTS_DIR"
  fi
}

echo
log_info "Package drift check (linux)"
echo

pkg_script="$HYPRDOTS_DIR/packages/linux/core.sh"
if [ ! -f "$pkg_script" ]; then
  log_err "No package script at $pkg_script"
  exit 1
fi

hyprdots_declared="$(extract_packages_from_script "$pkg_script")"

omarchy_base_file="$HOME/.local/share/omarchy/install/omarchy-base.packages"
omarchy_base="$(extract_omarchy_base "$omarchy_base_file")"

arch_essentials="$(printf '%s\n' "${ARCH_ESSENTIALS[@]}" | sort -u)"

sibling_dir="$(resolve_sibling_dir)"
sibling_declared=""
if [ -n "$sibling_dir" ]; then
  sibling_script="$sibling_dir/packages/linux/core.sh"
  if [ -f "$sibling_script" ]; then
    sibling_declared="$(extract_packages_from_script "$sibling_script")"
    log_info "Sibling repo: $sibling_dir (filtering its declarations)"
  else
    log_info "Sibling repo at $sibling_dir but no packages/linux/core.sh — skipping sibling filter"
  fi
else
  log_info "No sibling repo (appdots) on this machine — drift report won't filter its packages"
fi

installed="$(pacman -Qqett 2>/dev/null | sort -u)"

known="$(printf '%s\n%s\n%s\n%s\n' \
  "$hyprdots_declared" "$omarchy_base" "$arch_essentials" "$sibling_declared" \
  | sort -u | grep -v '^$')"

extra="$(comm -23 <(echo "$installed") <(echo "$known"))"
missing="$(comm -23 <(echo "$hyprdots_declared") <(echo "$installed"))"

drift=0

if [ -n "$extra" ]; then
  log_warn "Installed but not declared anywhere known to hyprdots:"
  echo "$extra" | sed 's/^/  + /'
  echo
  drift=1
fi

if [ -n "$missing" ]; then
  log_warn "Declared by hyprdots but not installed:"
  echo "$missing" | sed 's/^/  - /'
  echo
  drift=1
fi

[ "$drift" -eq 0 ] && log_ok "Package set matches declarations."
exit "$drift"
