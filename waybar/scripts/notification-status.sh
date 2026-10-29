#!/bin/bash
# Obtener el número de notificaciones no leídas desde swaync

# Intenta conectarse a swaync para obtener el estado
NOTIFICATIONS=$(swaync-client -c 2>/dev/null | grep -c '"id"')
NOTIFICATIONS=${NOTIFICATIONS:-0}

# Crear salida JSON para waybar
if [ "$NOTIFICATIONS" -gt 0 ]; then
    # Si hay notificaciones, mostrar un punto rojo
    echo "{\"text\": \"󰂚 $NOTIFICATIONS\", \"class\": \"notifications-active\", \"tooltip\": \"$NOTIFICATIONS notificaciones pendientes\\n(Click: abrir)\\n(Right-click: borrar todas)\"}"
else
    # Si no hay notificaciones
    echo "{\"text\": \"󰂜\", \"class\": \"notifications-empty\", \"tooltip\": \"Sin notificaciones\\n(Click: abrir centro)\\n(Right-click: borrar todas)\"}"
fi
