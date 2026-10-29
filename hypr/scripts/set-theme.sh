#!/bin/sh
# Cambia el tema activo de Hyprland.
# Uso: set-theme.sh <nombre-del-tema>   (ej: catppuccin-mocha, catppuccin-latte, summer-day)
#
# Requiere que existan:
#   ~/.config/hypr/themes/<nombre>/<nombre>.lua   (módulo Lua del tema)
#   ~/.config/hypr/themes/<nombre>/<nombre>.json  (datos para switch-theme.sh)

HYPR_LUA="$HOME/.config/hypr/hyprland.lua"
THEMES_DIR="$HOME/.config/hypr/themes"
LOG="${XDG_RUNTIME_DIR:-/tmp}/set-theme.log"

notify() {
	notify-send "Tema" "$1" 2>/dev/null
}

NAME="$1"

if [ -z "$NAME" ]; then
	echo "uso: set-theme.sh <nombre-del-tema>" >&2
	exit 1
fi

# Solo nombres simples, para que el valor escrito en Lua sea seguro
case "$NAME" in
	*[!a-z0-9-]*|"")
		notify "Nombre de tema no válido: $NAME"
		echo "nombre de tema no válido: $NAME" >&2
		exit 1
		;;
esac

if [ ! -f "$THEMES_DIR/$NAME/$NAME.lua" ] || [ ! -f "$THEMES_DIR/$NAME/$NAME.json" ]; then
	notify "$NAME todavía no está migrado a Lua"
	echo "falta $THEMES_DIR/$NAME/$NAME.lua o .json" >&2
	exit 1
fi

# Cambiar la variable de tema en hyprland.lua
sed -i -E "s/^local themeName = \".*\"/local themeName = \"$NAME\"/" "$HYPR_LUA"

# Aplicar wallpaper, waybar, kitty, GTK, fuente, dock.
# Va en segundo plano y desligado de esta shell: el script puede tardar, y
# el dock no debe heredar el descriptor de lock.
setsid -f sh "$HOME/.config/hypr/scripts/switch-theme.sh" "$NAME" >"$LOG" 2>&1 9>&-

hyprctl reload >/dev/null 2>&1
notify "Tema activo: $NAME"
