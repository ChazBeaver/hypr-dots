#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# hyprdots/sync.sh
# Declarative symlink sync. Idempotent, safe to run repeatedly.
# Links active/omarchy/.config/* and active/shared/.config/* into ~/.config/
#
# Run after every git pull to apply changes.
# For a fresh machine, run bootstrap.sh instead.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")" &>/dev/null && pwd)"
ACTIVE_DIR="$SCRIPT_DIR/active"
ENV_FILE="$HOME/.dotfiles-env.sh"
VAR_NAME="HYPR_DOTS_DIR"

# shellcheck source=lib/log.sh
source "$SCRIPT_DIR/lib/log.sh"
# shellcheck source=lib/detect.sh
source "$SCRIPT_DIR/lib/detect.sh"
# shellcheck source=lib/link.sh
source "$SCRIPT_DIR/lib/link.sh"

assert_linux

cat <<'EOF'


 _   ___   ___________________ _____ _____ _____ 
| | | \ \ / / ___ \ ___ \  _  \  _  |_   _/  ___|
| |_| |\ V /| |_/ / |_/ / | | | | | | | | \ `--. 
|  _  | \ / |  __/|    /| | | | | | | | |  `--. \
| | | | | | | |   | |\ \| |/ /\ \_/ / | | /\__/ /
\_| |_/ \_/ \_|   \_| \_|___/  \___/  \_/ \____/ 
                                                 
                Syncing Hyprdots

EOF

# ---- Persist HYPR_DOTS_DIR ----
if [ -z "${HYPR_DOTS_DIR:-}" ]; then
  if [[ "$SCRIPT_DIR" == "$HOME"* ]]; then
    export HYPR_DOTS_DIR="$SCRIPT_DIR"
    log_info "Set HYPR_DOTS_DIR to $SCRIPT_DIR"
  else
    log_warn "hyprdots not inside home directory. Set HYPR_DOTS_DIR manually."
  fi
fi

mkdir -p "$(dirname "$ENV_FILE")"
grep -q "$VAR_NAME=" "$ENV_FILE" 2>/dev/null \
  || echo "export $VAR_NAME=\"$SCRIPT_DIR\"" >> "$ENV_FILE"
grep -q 'alias hyprdots=' "$ENV_FILE" 2>/dev/null \
  || echo 'alias hyprdots="cd \$HYPR_DOTS_DIR"' >> "$ENV_FILE"
# shellcheck disable=SC1090
source "$ENV_FILE" || true

# ---- Symlink sync ----
log_step "Linking Omarchy-specific configs..."
install_scope "$ACTIVE_DIR/omarchy"

log_step "Linking shared configs..."
install_scope "$ACTIVE_DIR/shared"

# ---- Bin sync ----
install_bin_scope "$SCRIPT_DIR/bin"

echo
log_ok "Sync complete."
log_info "You may want to reload Hyprland: hyprctl reload"
