#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# ============================================================================
# hypr-dots Install Script (for active/.config structure)
# ============================================================================

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")" &>/dev/null && pwd)"
ACTIVE_DIR="$SCRIPT_DIR/active/.config"

VAR_NAME="HYPR_DOTS_DIR"

if [ -z "${HYPR_DOTS_DIR:-}" ]; then
  if [[ "$SCRIPT_DIR" == "$HOME"* ]]; then
    export HYPR_DOTS_DIR="$SCRIPT_DIR"
    echo "Set HYPR_DOTS_DIR to $SCRIPT_DIR"
  else
    echo "Warning: hypr-dots not inside home directory. Please set HYPR_DOTS_DIR manually."
  fi
fi

# Persist to ~/.dotfiles-env.sh
ENV_FILE="$HOME/.dotfiles-env.sh"
mkdir -p "$(dirname "$ENV_FILE")"

# Save HYPR_DOTS_DIR to ENV file if missing
if ! grep -q "$VAR_NAME=" "$ENV_FILE" 2>/dev/null; then
  echo "export $VAR_NAME=\"$SCRIPT_DIR\"" >> "$ENV_FILE"
  echo "Added $VAR_NAME to $ENV_FILE."
fi

# ✅ Add alias for hyprdots if not already there
if ! grep -q 'alias hyprdots=' "$ENV_FILE" 2>/dev/null; then
  echo 'alias hyprdots="cd \$HYPR_DOTS_DIR"' >> "$ENV_FILE"
  echo "Added alias 'hyprdots' to $ENV_FILE."
fi

source "$ENV_FILE"

# ------------------------
# Symlink Function
# ------------------------

link_item() {
  local source_path="$1"
  local target_path="$2"

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    if [ "$(readlink "$target_path" || true)" = "$source_path" ]; then
      echo "✅ Already linked correctly: $target_path -> $source_path"
    else
      echo "⚠️  Warning: $target_path exists but points elsewhere. Skipping."
    fi
  else
    mkdir -p "$(dirname "$target_path")"
    ln -s "$source_path" "$target_path"
    echo "🔗 Linked: $target_path -> $source_path"
  fi
}

# ------------------------
# Link Everything Inside active/.config
# ------------------------
cat <<'EOF'

 _   ___   _____________      ______ _____ _____ _____ 
| | | \ \ / / ___ \ ___ \     |  _  \  _  |_   _/  ___|
| |_| |\ V /| |_/ / |_/ /_____| | | | | | | | | \ --. 
|  _  | \ / |  __/|    /______| | | | | | | | |  --. \
| | | | | | | |   | |\ \      | |/ /\ \_/ / | | /\__/ /
\_| |_/ \_/ \_|   \_| \_|     |___/  \___/  \_/ \____/ 

                 Installing Hypr-Dots


EOF

echo "🔍 Scanning active/.config for files and directories to link..."

find "$ACTIVE_DIR" -mindepth 1 -maxdepth 1 | while read -r item; do
  relative_name="${item#$ACTIVE_DIR/}"
  source_path="$item"
  target_path="$HOME/.config/$relative_name"

  link_item "$source_path" "$target_path"
done

echo "✅ Finished installing hypr-dots."
