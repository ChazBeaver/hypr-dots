#!/usr/bin/env bash
set -euo pipefail

action="${1:-}"
amount="${2:-10}"

current="$(
  ddcutil getvcp 10 --terse \
    | awk -F'[=,]' '{gsub(/ /, "", $2); print $2}'
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

(( new < 0 )) && new=0
(( new > 100 )) && new=100

ddcutil setvcp 10 "$new" >/dev/null
echo "$new"
