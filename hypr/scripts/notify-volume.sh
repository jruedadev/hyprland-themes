#!/bin/sh
# Shows a notification with the current volume/mute state.

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | head -1 | grep -oP '\d+(?=%)' | head -1)
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o "yes")

if [ "$MUTED" = "yes" ]; then
    notify-send -h string:x-canonical-private-synchronous:volume -t 1500 "Volume: muted"
else
    notify-send -h string:x-canonical-private-synchronous:volume -t 1500 "Volume: ${VOLUME}%"
fi
