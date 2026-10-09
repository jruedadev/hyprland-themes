#!/bin/sh

# getting json config values
GTK_THEME=$(jq -r ".gtkTheme" ~/.config/hypr/themes/$1/$1.json)
COLOR_SCHEME=$(jq -r ".colorScheme" ~/.config/hypr/themes/$1/$1.json)
ICON_THEME=$(jq -r ".iconTheme" ~/.config/hypr/themes/$1/$1.json)
FONT=$(jq -r ".font" ~/.config/hypr/themes/$1/$1.json)

# wallpaper
killall hyprpaper 2>/dev/null
hyprpaper -c ~/.config/hypr/hyprpaper/$COLOR_SCHEME.conf &

# Change Waybar output depending on monitor
source ~/.config/hypr/scripts/detect-outputs.sh
sed -i -E 's/("output": ")(.*)(",)/\1'"$MAIN_DISPLAY"'\3/g' ~/.config/waybar/$COLOR_SCHEME/config

# waybar
killall waybar 2>/dev/null
waybar --config ~/.config/waybar/$COLOR_SCHEME/config --style ~/.config/waybar/$COLOR_SCHEME/style.css &

# swaync (notification toasts)
if [ -f ~/.config/swaync/style-$COLOR_SCHEME.css ]; then
	ln -sf ~/.config/swaync/style-$COLOR_SCHEME.css ~/.config/swaync/style.css
	swaync-client --reload-css >/dev/null 2>&1
fi

# gtk theme
sh ~/.config/hypr/scripts/set-gtk-theme.sh "$GTK_THEME"

# font
sh ~/.config/hypr/scripts/set-font.sh "$FONT"

# icon theme
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

# kitty
sed -i '1d' ~/.config/kitty/kitty.conf
sed -i '1i\include colors/'$COLOR_SCHEME'.conf' ~/.config/kitty/kitty.conf
pidof kitty >/dev/null && kill -s USR1 $(pidof kitty)

# docking (dock): tema opcional por tema, definido como "dockTheme" en el json
DOCK_THEME=$(jq -r '.dockTheme // empty' ~/.config/hypr/themes/$1/$1.json)
DOCK_CONFIG=~/.config/docking/dock.json
if [ -n "$DOCK_THEME" ] && [ -f "$DOCK_CONFIG" ] && [ "$(jq -r '.theme' "$DOCK_CONFIG")" != "$DOCK_THEME" ]; then
	jq --arg t "$DOCK_THEME" '.theme = $t' "$DOCK_CONFIG" > "$DOCK_CONFIG.tmp" && mv "$DOCK_CONFIG.tmp" "$DOCK_CONFIG"
	# docking no recarga la config en caliente, hay que reiniciarlo
	# docking tarda en cerrarse; esperar a que termine antes de lanzar otro
	pkill -f "^/usr/bin/python3 -m docking.app"
	for i in 1 2 3 4 5 6 7 8 9 10; do
		pgrep -f "^/usr/bin/python3 -m docking.app" >/dev/null || break
		sleep 0.5
	done
	pkill -9 -f "^/usr/bin/python3 -m docking.app" 2>/dev/null
	docking >/dev/null 2>&1 &
fi
