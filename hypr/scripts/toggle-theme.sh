#!/bin/sh
# Alterna entre los temas Everforest claro (summer-day) y oscuro (summer-night)

HYPR_CONF="$HOME/.config/hypr/hyprland.lua"

CURRENT=$(grep -oE 'themes/[a-zA-Z0-9_-]+/' "$HYPR_CONF" | head -n1 | cut -d/ -f2)

if [ "$CURRENT" = "summer-day" ]; then
	NEXT="summer-night"
else
	NEXT="summer-day"
fi

sed -i -E "s#themes/(summer-day|summer-night)/\1\.conf#themes/${NEXT}/${NEXT}.conf#" "$HYPR_CONF"

sh "$HOME/.config/hypr/scripts/switch-theme.sh" "$NEXT"

hyprctl reload
