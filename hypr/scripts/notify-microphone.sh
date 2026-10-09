#!/bin/sh
# Toggle microphone mute and show notification

SOURCE=$(pactl get-default-source)
IS_MUTED=$(pactl get-source-mute "$SOURCE" | grep -o "yes\|no")

if [ "$IS_MUTED" = "yes" ]; then
    pactl set-source-mute "$SOURCE" 0
    STATUS="Microphone: ON"
else
    pactl set-source-mute "$SOURCE" 1
    STATUS="Microphone: MUTED"
fi

notify-send -h string:x-canonical-private-synchronous:microphone -t 1500 "$STATUS"
