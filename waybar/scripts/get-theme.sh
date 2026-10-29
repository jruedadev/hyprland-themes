#!/usr/bin/env bash
# Detecta el tema actual de Hyprland y lo mapea al tema de wofi

HYPRLAND_LUA="$HOME/.config/hypr/hyprland.lua"

# Extrae el tema de la línea 'local themeName = "..."' de hyprland.lua
THEME_PATH=$(sed -n -E 's/^local themeName = "([^"]+)".*/\1/p' "$HYPRLAND_LUA" | head -n1)

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
