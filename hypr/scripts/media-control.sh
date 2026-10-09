#!/bin/sh
# Media player control with notification

ACTION="${1:-play-pause}"

case "$ACTION" in
    play-pause)
        playerctl play-pause
        ;;
    next)
        playerctl next
        ;;
    prev)
        playerctl previous
        ;;
    stop)
        playerctl stop
        ;;
esac

# Small delay to ensure playerctl state is updated
sleep 0.1

PLAYER_STATUS=$(playerctl status 2>/dev/null)
PLAYER_TITLE=$(playerctl metadata title 2>/dev/null)
PLAYER_ARTIST=$(playerctl metadata artist 2>/dev/null)

if [ -z "$PLAYER_STATUS" ]; then
    notify-send -h string:x-canonical-private-synchronous:media -t 1500 "No media player active"
    exit 0
fi

if [ "$PLAYER_STATUS" = "Playing" ]; then
    ICON="▶"
    STATUS="Playing"
elif [ "$PLAYER_STATUS" = "Paused" ]; then
    ICON="⏸"
    STATUS="Paused"
else
    ICON="⏹"
    STATUS="Stopped"
fi

if [ -n "$PLAYER_TITLE" ] && [ -n "$PLAYER_ARTIST" ]; then
    notify-send -h string:x-canonical-private-synchronous:media -t 1500 "$ICON $STATUS" "$PLAYER_ARTIST - $PLAYER_TITLE"
elif [ -n "$PLAYER_TITLE" ]; then
    notify-send -h string:x-canonical-private-synchronous:media -t 1500 "$ICON $STATUS" "$PLAYER_TITLE"
else
    notify-send -h string:x-canonical-private-synchronous:media -t 1500 "$ICON $STATUS"
fi
