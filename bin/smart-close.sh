#!/bin/bash

# Pega a classe da janela ativa
ACTIVE_CLASS=$(hyprctl activewindow -j | jq -r .class)

if [ "$ACTIVE_CLASS" == "Spotify" ] || [ "$ACTIVE_CLASS" == "spotify" ]; then
    # Se for Spotify, apenas move para um workspace especial "escondido"
    # Isso mantém o processo vivo e tocando.
    hyprctl dispatch movetoworkspacesilent special:spotify
    notify-send "Spotify" "Minimizado para segundo plano" -i spotify
else
    # Para qualquer outra janela, fecha normalmente
    hyprctl dispatch killactive
fi
