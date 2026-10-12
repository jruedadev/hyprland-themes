#!/bin/sh
# Alterna entre los temas Everforest claro (summer-day) y oscuro (summer-night)

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

CURRENT=$(grep -oE 'themes/[a-zA-Z0-9_-]+/' "$HYPR_CONF" | head -n1 | cut -d/ -f2)

if [ "$CURRENT" = "summer-day" ]; then
	NEXT="summer-night"
else
	NEXT="summer-day"
fi

sed -i -E "s#themes/[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+\.conf#themes/${NEXT}/${NEXT}.conf#" "$HYPR_CONF"

sh "$HOME/.config/hypr/scripts/switch-theme.sh" "$NEXT"

hyprctl reload
