#!/bin/bash

# Diretório de screenshots
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Nome do arquivo temporário
TEMP_FILE="/tmp/screenshot_$(date +%Y%m%d_%H%M%S).png"

# Capturar área selecionada
if ! grim -g "$(slurp)" "$TEMP_FILE"; then
    exit 1
fi

# Copiar para o clipboard (sempre acontece)
wl-copy < "$TEMP_FILE"

# Enviar notificação com botões de ação
# O notify-send --wait retorna a chave da ação escolhida
ACTION=$(notify-send "Screenshot" "Copiado para o clipboard" \
    -i "$TEMP_FILE" \
    --action="save=💾 Salvar" \
    --action="save_as=📂 Salvar como..." \
    --action="edit=✏️ Editar")

case "$ACTION" in
    "save")
        FILENAME="Screenshot_$(date +%Y%m%d_%H%M%S).png"
        cp "$TEMP_FILE" "$SAVE_DIR/$FILENAME"
        notify-send "Screenshot" "Salvo em $SAVE_DIR/$FILENAME" -i "$SAVE_DIR/$FILENAME"
        ;;
    "save_as")
        FILENAME="Screenshot_$(date +%Y%m%d_%H%M%S).png"
        SAVE_PATH=$(zenity --file-selection --save --confirm-overwrite --filename="$SAVE_DIR/$FILENAME" --file-filter="*.png")
        if [ -n "$SAVE_PATH" ]; then
            [[ "$SAVE_PATH" == *.png ]] || SAVE_PATH="${SAVE_PATH}.png"
            cp "$TEMP_FILE" "$SAVE_PATH"
            notify-send "Screenshot" "Salvo em $SAVE_PATH" -i "$SAVE_PATH"
        fi
        ;;
    "edit")
        if command -v swappy >/dev/null; then
            swappy -f "$TEMP_FILE"
        else
            notify-send "Screenshot" "Ferramenta de edição (swappy) não encontrada." -u critical
        fi
        ;;
esac

# Limpar arquivo temporário após um tempo para a notificação conseguir exibir a imagem
(sleep 20 && rm "$TEMP_FILE") &
