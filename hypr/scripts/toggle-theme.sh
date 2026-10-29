#!/bin/sh
# Alterna entre los temas Everforest claro (summer-day) y oscuro (summer-night)

HYPR_LUA="$HOME/.config/hypr/hyprland.lua"

CURRENT=$(sed -n -E 's/^local themeName = "([^"]+)".*/\1/p' "$HYPR_LUA" | head -n1)

if [ "$CURRENT" = "summer-day" ]; then
	NEXT="summer-night"
else
	NEXT="summer-day"
fi

sh "$HOME/.config/hypr/scripts/set-theme.sh" "$NEXT"
