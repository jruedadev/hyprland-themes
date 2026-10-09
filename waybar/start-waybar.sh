#!/bin/bash
# Script to start waybar with the correct configuration

THEME="${1:-everforest}"
CONFIG_DIR="$HOME/.config/waybar"

# Kill existing waybar instances
killall waybar 2>/dev/null

# Wait a bit
sleep 0.5

# Start waybar with the specified theme
waybar \
  -c "$CONFIG_DIR/$THEME/config" \
  -s "$CONFIG_DIR/$THEME/style.css" &

echo "✅ Waybar iniciado con tema: $THEME"
