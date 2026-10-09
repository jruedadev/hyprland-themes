#!/usr/bin/env bash
# Wofi dropdown menu to manage bluetooth power and paired devices

THEME="$(bash ~/.config/waybar/scripts/get-theme.sh)"
WOFI_OPTS="$1"

POWERED=$(bluetoothctl show | grep -o "Powered: yes")

if [ -n "$POWERED" ]; then
	TOGGLE="󰂲  Turn bluetooth off"
else
	TOGGLE="󰂯  Turn bluetooth on"
fi

MANAGER="  Open manager (blueman)"

DEVICES=""
if [ -n "$POWERED" ]; then
	while IFS= read -r line; do
		[ -z "$line" ] && continue
		MAC=$(echo "$line" | awk '{print $2}')
		NAME=$(echo "$line" | cut -d' ' -f3-)
		if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
			DEVICES+="󰂱  Disconnect: ${NAME}"$'\n'
		else
			DEVICES+="󰂯  Connect: ${NAME}"$'\n'
		fi
	done < <(bluetoothctl devices Paired)
fi

MENU="${TOGGLE}
${DEVICES}${MANAGER}"

CHOICE=$(echo "$MENU" | sed '/^$/d' | wofi $WOFI_OPTS -i -d --style ~/.config/wofi/themes/"$THEME".css --prompt "Bluetooth: ")

case "$CHOICE" in
"$TOGGLE")
	if [ -n "$POWERED" ]; then
		bluetoothctl power off
	else
		bluetoothctl power on
	fi
	;;
"$MANAGER")
	blueman-manager &
	;;
"󰂱  Disconnect: "*)
	NAME="${CHOICE#󰂱  Disconnect: }"
	MAC=$(bluetoothctl devices Paired | while IFS= read -r l; do
		n=$(echo "$l" | cut -d' ' -f3-)
		[ "$n" = "$NAME" ] && echo "$l" | awk '{print $2}' && break
	done)
	[ -n "$MAC" ] && bluetoothctl disconnect "$MAC"
	;;
"󰂯  Connect: "*)
	NAME="${CHOICE#󰂯  Connect: }"
	MAC=$(bluetoothctl devices Paired | while IFS= read -r l; do
		n=$(echo "$l" | cut -d' ' -f3-)
		[ "$n" = "$NAME" ] && echo "$l" | awk '{print $2}' && break
	done)
	[ -n "$MAC" ] && bluetoothctl connect "$MAC"
	;;
esac
