#!/bin/bash
ACTIVE="$HOME/.config/hypr/overlay/gaps-toggle/active/gaps.conf"
TEMPLATE="$HOME/.config/hypr/overlay/gaps-toggle/template/gaps.conf"

if [[ -f "$ACTIVE" ]]; then
    rm "$ACTIVE"
    notify-send -u low "Window gaps disabled"
else
    cp "$TEMPLATE" "$ACTIVE"
    notify-send -u low "Window gaps enabled"
fi

hyprctl reload
