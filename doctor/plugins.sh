#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%N}}")/.." &>/dev/null && pwd)"
source "$REPO_DIR/lib/log.sh"

shell_config="$REPO_DIR/active/omarchy/.config/omarchy/shell.json"
shell_defaults="/usr/share/omarchy/config/omarchy/shell.json"

if ! jq -e --slurpfile defaults "$shell_defaults" '
  def widget_ids($layout):
    [$layout.left[], $layout.center[], $layout.right[] | .id] | sort;
  widget_ids(.bar.layout) == widget_ids($defaults[0].bar.layout)
    and any(.bar.layout.center[]; .id == "omarchy.clock" and .format == "dddd h:mm AP")
' "$shell_config" >/dev/null; then
  log_err "Omarchy bar widget set or AM/PM clock drifted from the Quattro baseline: $shell_config"
  exit 1
fi

plugin_root="$REPO_DIR/active/omarchy/.config/omarchy/plugins"
for plugin in chaz.lock chaz.idle; do
  manifest="$plugin_root/$plugin/manifest.json"
  jq -e --arg id "$plugin" '.schemaVersion == 1 and .id == $id and .keepLoaded == true and .omarchy.clonedFrom' "$manifest" >/dev/null || {
    log_err "Invalid plugin manifest: $manifest"
    exit 1
  }
done

qmllint -I /usr/share/omarchy/shell \
  "$plugin_root/chaz.lock/LockView.qml" \
  "$plugin_root/chaz.lock/Service.qml" \
  "$plugin_root/chaz.idle/Service.qml"

installed_version="$(pacman -Q omarchy 2>/dev/null | awk '{print $2}')"
for upstream in "$plugin_root"/*/UPSTREAM; do
  recorded_version="$(awk 'NR == 1 { print $2 }' "$upstream")"
  if [[ -n "$installed_version" && "$recorded_version" != "$installed_version" ]]; then
    log_warn "Plugin baseline $(dirname "$upstream") is $recorded_version; installed Omarchy is $installed_version"
  fi
done

if [[ "${HYPRDOTS_OFFLINE:-0}" != "1" ]] && omarchy-shell shell ping >/dev/null 2>&1; then
  catalog="$(omarchy plugin list --json 2>/dev/null || omarchy-plugin-list --json)"
  for plugin in chaz.lock chaz.idle; do
    jq -e --arg id "$plugin" 'any(.[]; .id == $id and .enabled == true)' <<< "$catalog" >/dev/null || {
      log_err "Omarchy shell plugin is not enabled: $plugin"
      exit 1
    }
  done
fi

log_ok "Repo-managed Quattro bar and personal plugins are valid"
