#!/bin/sh
# Shows a notification with the current brightness level

BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PERCENT=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

notify-send -h string:x-canonical-private-synchronous:brightness -t 1500 "Brightness: ${PERCENT}%"
