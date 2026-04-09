#!/bin/bash

# Pega a classe da janela ativa
ACTIVE_CLASS=$(hyprctl activewindow -j | jq -r .class)

# Debug (opcional, pode remover depois)
# notify-send "Closing" "Class: $ACTIVE_CLASS"

if [ "$ACTIVE_CLASS" == "Spotify" ] || [ "$ACTIVE_CLASS" == "spotify" ]; then
    # Se for Spotify, apenas move para um workspace especial "escondido"
    hyprctl dispatch movetoworkspacesilent special:spotify
    notify-send "Spotify" "Minimizado para segundo plano" -i spotify
else
    # Para qualquer outra janela, fecha normalmente
    hyprctl dispatch killactive
fi
