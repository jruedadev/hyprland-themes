#!/bin/sh
# Toggle touchpad and show notification

ACTION="${1:-toggle}"

case "$ACTION" in
    off)
        STATUS="Touchpad: OFF"
        ;;
    on)
        STATUS="Touchpad: ON"
        ;;
    toggle)
        # Check current state
        CURRENT=$(xinput list-props "Synaptics TouchPad" 2>/dev/null | grep "Device Enabled" | grep -o "[01]$")
        if [ "$CURRENT" = "1" ]; then
            STATUS="Touchpad: OFF"
        else
            STATUS="Touchpad: ON"
        fi
        ;;
esac

notify-send -h string:x-canonical-private-synchronous:touchpad -t 1500 "$STATUS"
