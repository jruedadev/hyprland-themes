#!/bin/sh
# Toggle airplane mode (disable/enable WiFi and Bluetooth)

WIFI_STATUS=$(rfkill list wifi | grep -o "Soft blocked: yes\|Soft blocked: no" | head -1)

if [ "$WIFI_STATUS" = "Soft blocked: yes" ]; then
    rfkill unblock wifi
    rfkill unblock bluetooth
    STATUS="Airplane Mode: OFF"
else
    rfkill block wifi
    rfkill block bluetooth
    STATUS="Airplane Mode: ON"
fi

notify-send -h string:x-canonical-private-synchronous:airplane -t 1500 "$STATUS"
