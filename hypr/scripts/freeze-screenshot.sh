#!/bin/sh

mkdir -p "$HOME/Imágenes/screenshots"

if [ "$1" -eq 0 ]; then
    grim -g "$(slurp)" "$HOME/Imágenes/screenshots/$(date +'%s_grim.png')"
elif [ "$1" -eq 1 ]; then
    grim -g "$(slurp)" - | wl-copy
fi
