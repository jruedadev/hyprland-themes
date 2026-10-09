#!/usr/bin/env bash
# Detecta el tema actual de Hyprland y lo mapea al tema de wofi

HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"

# Extrae el tema de la línea "source = ~/.config/hypr/themes/..."
THEME_PATH=$(grep "source.*themes" "$HYPRLAND_CONF" | sed 's|.*themes/||; s|/.*||')

# Mapea el tema de Hyprland al tema de wofi
case "$THEME_PATH" in
  "summer-day")
    echo "everforest-light"
    ;;
  "summer-night")
    echo "everforest"
    ;;
  "catppuccin-latte")
    echo "catppuccin-latte"
    ;;
  "catppuccin-mocha")
    echo "catppuccin-mocha"
    ;;
  *)
    echo "everforest-light"
    ;;
esac
