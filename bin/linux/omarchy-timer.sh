#!/bin/bash
# Interactive timer prompt — uses walker to ask for duration and message,
# then hands off to omarchy-timer-fire to schedule the notification.
#
# Designed to be bound to a Hyprland keybind (e.g. SUPER CTRL ALT + T).
#
# Flow:
#   1. Walker prompts for duration with example placeholder.
#   2. Walker prompts for message with example placeholder.
#   3. Hands off to omarchy-timer-fire.
#
# Cancel/empty handling:
#   - Escape or empty duration → silent exit.
#   - Escape on message prompt → silent exit.
#   - Empty message → defaults to "Time's up".
#   - Invalid duration → mako critical notification, exit.

export PATH="$HOME/.local/share/omarchy/bin:$PATH"

# Prompt for duration. Empty input list → walker acts as a free-text input.
duration=$(echo -n "" | omarchy-launch-walker --dmenu --width 400 --minheight 1 -p "Duration (e.g. 5m, 1h30m, 45s)…" 2>/dev/null)

# Cancel or empty → silent exit.
if [[ -z "$duration" ]]; then
  exit 0
fi

# Prompt for message. Empty is allowed (primitive will default).
message=$(echo -n "" | omarchy-launch-walker --dmenu --width 400 --minheight 1 -p "Message (e.g. tea is ready)…" 2>/dev/null)

# Hand off. If message is empty, omit it so the primitive's default kicks in.
if [[ -z "$message" ]]; then
  if ! output=$(omarchy-timer-fire "$duration" 2>&1); then
    notify-send -u critical -a "omarchy-timer" "Timer failed" "$output"
    exit 1
  fi
else
  if ! output=$(omarchy-timer-fire "$duration" "$message" 2>&1); then
    notify-send -u critical -a "omarchy-timer" "Timer failed" "$output"
    exit 1
  fi
fi
