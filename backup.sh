#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# hyprdots/backup.sh
# Back up any real (non-symlink) ~/.config entries that sync.sh would replace.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")" &>/dev/null && pwd)"
ACTIVE_DIR="$SCRIPT_DIR/active"

# shellcheck source=lib/log.sh
source "$SCRIPT_DIR/lib/log.sh"
# shellcheck source=lib/detect.sh
source "$SCRIPT_DIR/lib/detect.sh"
# shellcheck source=lib/backup.sh
source "$SCRIPT_DIR/lib/backup.sh"

assert_linux

cat <<'EOF'

 _   ___   ___________________ _____ _____ _____ 
| | | \ \ / / ___ \ ___ \  _  \  _  |_   _/  ___|
| |_| |\ V /| |_/ / |_/ / | | | | | | | | \ `--. 
|  _  | \ / |  __/|    /| | | | | | | | |  `--. \
| | | | | | | |   | |\ \| |/ /\ \_/ / | | /\__/ /
\_| |_/ \_/ \_|   \_| \_|___/  \___/  \_/ \____/ 
                                                 
       _
      | |__   __ _  ___| | ___   _ _ __
      | '_ \ / _` |/ __| |/ / | | | '_ \
      | |_) | (_| | (__|   <| |_| | |_) |
      |_.__/ \__,_|\___|_|\_\\__,_| .__/
                                   |_|
EOF

echo
log_info "Backing up Hyprland dotfiles before sync..."
echo

backup_scope "$ACTIVE_DIR/omarchy"
backup_scope "$ACTIVE_DIR/shared"

echo
log_ok "Backup complete. You're ready to run ./sync.sh"
