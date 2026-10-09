#!/bin/bash

entries="Summer-Day\nSummer-Night\nCatppuccin-Latte\nCatppuccin-Mocha"
source='source = ~/.config/hypr/themes/'
hyprland-conf=~/.config/hypr/hyprland.conf
# delete-line="$(sed -i '1d' ~/.config/hypr/hyprland.conf)"

selected=$(echo -e $entries|wofi --dmenu $2 --style ~/.config/wofi/themes/$1.css --hide-scroll --cache-file /dev/null)

hyprland_conf=~/.config/hypr/hyprland.conf
set_theme() {
  sed -i -E "s|^source = ~/\.config/hypr/themes/.*|source = ~/.config/hypr/themes/$1|" "$hyprland_conf"
}

case $selected in
  Summer-Day)
    notify-send "Summer-Day"
    set_theme "summer-day/summer-day.conf"
    ;;
  Summer-Night)
    notify-send "Summer-Night"
    set_theme "summer-night/summer-night.conf"
    ;;
  Catppuccin-Latte)
    notify-send "Catppuccin Latte"
    set_theme "catppuccin-latte/catppuccin-latte.conf"
    ;;
  Catppuccin-Mocha)
    notify-send "Catppuccin Mocha"
    set_theme "catppuccin-mocha/catppuccin-mocha.conf"
    ;;
esac

hyprctl reload

# Actualizar waybar con el nuevo tema
sleep 1
bash ~/.config/waybar/start-waybar-theme.sh