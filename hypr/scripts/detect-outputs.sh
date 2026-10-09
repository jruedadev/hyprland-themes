#!/bin/sh
# Sets MAIN_DISPLAY to the currently focused monitor (used by waybar/wofi -o flags).

MAIN_DISPLAY=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

if [ -z "$MAIN_DISPLAY" ]; then
    MAIN_DISPLAY=$(hyprctl monitors -j | jq -r '.[0].name')
fi

export MAIN_DISPLAY
