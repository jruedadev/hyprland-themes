#!/bin/bash
# Menú wofi para elegir el tema de Hyprland. Aplica el cambio con set-theme.sh.

HYPR_LUA=~/.config/hypr/hyprland.lua
SET_THEME=~/.config/hypr/scripts/set-theme.sh

CURRENT=$(sed -n -E 's/^local themeName = "([^"]+)".*/\1/p' "$HYPR_LUA" | head -n1)
# El CSS de wofi se llama como el colorScheme del tema (ej: summer-day -> everforest-light)
WOFI_CSS=$(jq -r '.colorScheme // empty' ~/.config/hypr/themes/"$CURRENT"/"$CURRENT".json 2>/dev/null)
WOFI_CSS=${WOFI_CSS:-$CURRENT}

# Etiqueta visible -> nombre del tema
declare -A THEMES=(
	["Summer-Day"]="summer-day"
	["Summer-Night"]="summer-night"
	["Catppuccin-Latte"]="catppuccin-latte"
	["Catppuccin-Mocha"]="catppuccin-mocha"
)

entries=$(printf '%s\n' "${!THEMES[@]}" | sort)

selected=$(echo "$entries" | wofi --dmenu --style ~/.config/wofi/themes/"$WOFI_CSS".css --hide-scroll --cache-file /dev/null)

[ -z "$selected" ] && exit 0

NAME="${THEMES[$selected]}"
[ -z "$NAME" ] && exit 0

sh "$SET_THEME" "$NAME"
