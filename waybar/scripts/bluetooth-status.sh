#!/usr/bin/env bash
# Reports bluetooth status as JSON for waybar custom module

POWERED=$(bluetoothctl show | grep -o "Powered: yes")
CONNECTED=$(bluetoothctl devices Connected 2>/dev/null)

if [ -z "$POWERED" ]; then
	ICON="󰂲"
	TEXT="Off"
	CLASS="off"
	TOOLTIP="Bluetooth off\nClick to open menu"
elif [ -n "$CONNECTED" ]; then
	ICON="󰂱"
	NAMES=$(echo "$CONNECTED" | sed 's/^Device [^ ]* //' | paste -sd, -)
	COUNT=$(echo "$CONNECTED" | wc -l)
	TEXT="$COUNT"
	CLASS="connected"
	TOOLTIP="Connected: ${NAMES}\nClick to open menu"
else
	ICON="󰂯"
	TEXT=""
	CLASS="on"
	TOOLTIP="Bluetooth on, no device connected\nClick to open menu"
fi

printf '{"text": "%s %s", "tooltip": "%s", "class": "%s"}\n' "$ICON" "$TEXT" "$TOOLTIP" "$CLASS"
