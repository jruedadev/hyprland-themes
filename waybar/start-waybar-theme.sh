#!/usr/bin/env bash
# Inicia waybar con la configuración y estilo según el tema actual

THEME="$(bash ~/.config/waybar/scripts/get-theme.sh)"

# Mapea tema de wofi a configuración de waybar
case "$THEME" in
  "everforest-light")
    WAYBAR_THEME="everforest-light"
    ;;
  "everforest")
    WAYBAR_THEME="everforest"
    ;;
  "catppuccin-latte")
    WAYBAR_THEME="catppuccin-latte"
    ;;
  "catppuccin-mocha")
    WAYBAR_THEME="catppuccin-mocha"
    ;;
  *)
    WAYBAR_THEME="everforest-light"
    ;;
esac

killall waybar 2>/dev/null
sleep 1

waybar \
  -c ~/.config/waybar/$WAYBAR_THEME/config \
  -s ~/.config/waybar/$WAYBAR_THEME/style.css > /dev/null 2>&1 &

echo "Waybar iniciado con tema: $WAYBAR_THEME"
