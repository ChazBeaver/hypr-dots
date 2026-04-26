#!/usr/bin/env bash
set -euo pipefail
# hyprdots/bin/monitor-brightness.sh
# Control external monitor brightness via DDC/CI.
# Symlinked to ~/.local/bin/monitor-brightness by sync.sh
#
# Usage:
#   monitor-brightness up   [amount]   # default amount: 10
#   monitor-brightness down [amount]
#   monitor-brightness set  <value>    # 0-100

action="${1:-}"
amount="${2:-10}"

current="$(
  ddcutil getvcp 10 2>/dev/null \
    | sed -n 's/.*current value = *\([0-9]\+\).*/\1/p'
)"

if [[ -z "$current" ]]; then
  echo "Could not read current monitor brightness" >&2
  exit 1
fi

case "$action" in
  up)
    new=$(( current + amount ))
    ;;
  down)
    new=$(( current - amount ))
    ;;
  set)
    new=$amount
    ;;
  *)
    echo "Usage: monitor-brightness {up|down|set} [amount]" >&2
    exit 1
    ;;
esac

(( new < 0   )) && new=0
(( new > 100 )) && new=100

ddcutil setvcp 10 "$new" >/dev/null
echo "$new"
