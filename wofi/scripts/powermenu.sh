#!/bin/bash

entries="⭮ Reboot\n⏻ Shutdown\n⇠ Logout\n⏾ Suspend"

# Usa el estilo específico de apagado si existe para el tema; si no, el estilo normal
STYLE=~/.config/wofi/themes/$1-power.css
[ -f "$STYLE" ] || STYLE=~/.config/wofi/themes/$1.css

selected=$(echo -e $entries|wofi --width 260 --height 290 --dmenu --style "$STYLE" --hide-search --hide-scroll --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  logout)
    exec hyprctl dispatch exit NOW;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac