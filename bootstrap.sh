#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# hyprdots/bootstrap.sh
# One-time cold-boot orchestrator for a fresh Omarchy/Arch machine.
# Runs: backup → packages → sync
#
# Run this ONCE on a new machine.
# For ongoing updates (after git pull) run ./sync.sh instead.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")" &>/dev/null && pwd)"

# shellcheck source=lib/log.sh
source "$SCRIPT_DIR/lib/log.sh"
# shellcheck source=lib/detect.sh
source "$SCRIPT_DIR/lib/detect.sh"

assert_linux

cat <<'EOF'


 _   ___   ___________________ _____ _____ _____ 
| | | \ \ / / ___ \ ___ \  _  \  _  |_   _/  ___|
| |_| |\ V /| |_/ / |_/ / | | | | | | | | \ `--. 
|  _  | \ / |  __/|    /| | | | | | | | |  `--. \
| | | | | | | |   | |\ \| |/ /\ \_/ / | | /\__/ /
\_| |_/ \_/ \_|   \_| \_|___/  \___/  \_/ \____/ 
                                                 
               Cold-boot bootstrap

EOF

log_info "OS: $(uname -s)"
echo

# ---- 1. Backup ----
log_step "Step 1/3: Backup existing Hyprland configs"
"$SCRIPT_DIR/backup.sh"
echo

# ---- 2. Packages ----
pkg_script="$SCRIPT_DIR/packages/linux/core.sh"
if [ -x "$pkg_script" ]; then
  log_step "Step 2/3: Install packages"
  "$pkg_script"
else
  log_warn "Step 2/3: No package script at $pkg_script — skipping"
fi
echo

# ---- 3. Sync ----
log_step "Step 3/3: Symlink sync"
"$SCRIPT_DIR/sync.sh"
echo

log_ok "Bootstrap complete."
log_info "From now on, just run ./sync.sh after git pull."
log_info "To reload Hyprland config: hyprctl reload"
