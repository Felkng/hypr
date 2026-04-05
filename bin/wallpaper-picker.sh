#!/bin/bash
# Localização dos wallpapers (conforme seu waypaper config.ini)
WP_DIR="$HOME/Downloads"

# Listar imagens e selecionar usando o Walker no modo dmenu
SELECTED=$(ls -1 "$WP_DIR"/*.{png,jpg,jpeg,webp} | xargs -n 1 basename | walker --dmenu)

if [ -n "$SELECTED" ]; then
    # Aplicar o wallpaper usando o waypaper para persistência
    waypaper --wallpaper "$WP_DIR/$SELECTED"
    notify-send -u low "Wallpaper Aplicado" "O wallpaper foi alterado para: $SELECTED"
fi
