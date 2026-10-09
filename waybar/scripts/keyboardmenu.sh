#!/usr/bin/env bash
# Wofi dropdown menu to pick keyboard layout across all input devices
# Index 0 = Spanish/Latam layout, Index 1 = us(intl) (English, intl. dead keys)

THEME="$(bash ~/.config/waybar/scripts/get-theme.sh)"
WOFI_OPTS="$1"

OPT_ES="🇪🇸  Español (ES/LatAm)"
OPT_EN="🇺🇸  English (US intl.)"

CHOICE=$(printf "%s\n%s\n" "$OPT_ES" "$OPT_EN" | wofi $WOFI_OPTS -i -d --style ~/.config/wofi/themes/"$THEME".css --prompt "Keyboard layout: ")

case "$CHOICE" in
"$OPT_ES")
	INDEX=0
	;;
"$OPT_EN")
	INDEX=1
	;;
*)
	exit 0
	;;
esac

hyprctl devices -j | python3 -c "
import json, sys
data = json.load(sys.stdin)
for kb in data.get('keyboards', []):
    print(kb['name'])
" | while IFS= read -r device; do
	hyprctl switchxkblayout "$device" "$INDEX" >/dev/null
done
