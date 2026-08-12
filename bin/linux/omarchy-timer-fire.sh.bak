#!/bin/bash
# Set a one-shot timer that fires a mako notification with normal urgency.
#
# This is the primitive — takes args directly. For an interactive prompt-driven
# version, use `omarchy-timer` instead.
#
# Usage:
#   omarchy-timer-fire <duration> [message]
#
# Duration formats:
#   30s        30 seconds
#   5m         5 minutes
#   1h         1 hour
#   1h30m      1 hour 30 minutes
#   90         90 seconds (bare number = seconds)
#
# Examples:
#   omarchy-timer-fire 5m "tea is ready"
#   omarchy-timer-fire 1h30m "leave for appointment"
#   omarchy-timer-fire 45s

set -euo pipefail

print_usage() {
  cat <<EOF
Usage: omarchy-timer-fire <duration> [message]

Duration: 30s, 5m, 1h, 1h30m, or bare seconds (e.g. 90)
Message:  optional, defaults to "Time's up"

Examples:
  omarchy-timer-fire 5m "tea is ready"
  omarchy-timer-fire 1h30m "leave for appointment"
EOF
}

if [[ $# -lt 1 ]]; then
  print_usage
  exit 1
fi

duration_input="$1"
if [[ $# -ge 2 ]]; then
  message="$2"
else
  message="Time's up"
fi

# Parse duration into total seconds.
parse_duration() {
  local input="$1"
  local total=0

  # Bare number = seconds.
  if [[ "$input" =~ ^[0-9]+$ ]]; then
    if [[ "$input" -le 0 ]]; then
      return 1
    fi
    echo "$input"
    return 0
  fi

  # Match combinations like 1h30m, 5m, 45s, 2h, 1h5m30s.
  if [[ ! "$input" =~ ^([0-9]+h)?([0-9]+m)?([0-9]+s)?$ ]] || [[ -z "$input" ]]; then
    return 1
  fi

  local hours="${BASH_REMATCH[1]%h}"
  local minutes="${BASH_REMATCH[2]%m}"
  local seconds="${BASH_REMATCH[3]%s}"

  total=$(( ${hours:-0} * 3600 + ${minutes:-0} * 60 + ${seconds:-0} ))

  if [[ $total -le 0 ]]; then
    return 1
  fi

  echo "$total"
}

if ! total_seconds=$(parse_duration "$duration_input"); then
  echo "Error: invalid duration '$duration_input'" >&2
  echo "" >&2
  print_usage >&2
  exit 1
fi

# Format a human-readable "fires at" time.
fire_time=$(date -d "+${total_seconds} seconds" "+%H:%M:%S")

# Format a human-readable duration for the confirmation message.
format_duration() {
  local secs="$1"
  local h=$(( secs / 3600 ))
  local m=$(( (secs % 3600) / 60 ))
  local s=$(( secs % 60 ))
  local out=""
  [[ $h -gt 0 ]] && out+="${h}h"
  [[ $m -gt 0 ]] && out+="${m}m"
  [[ $s -gt 0 ]] && out+="${s}s"
  echo "$out"
}

pretty_duration=$(format_duration "$total_seconds")

# Fork to background so the shell returns immediately.
# disown so it survives terminal close.
(
  sleep "$total_seconds"
  notify-send -u normal -a "omarchy-timer" "⏰ Timer" "$message"
  # Sound is best-effort; don't fail the timer if audio is unavailable.
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || true
) &
disown

echo "✓ Timer set for ${pretty_duration} — fires at ${fire_time}"
echo "  Message: ${message}"
