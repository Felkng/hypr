#!/bin/bash
LOG_FILE="/tmp/swaync_debug.log"
echo "--- $(date) ---" >> "$LOG_FILE"
echo "Summary: $SWAYNC_SUMMARY" >> "$LOG_FILE"
echo "Body: $SWAYNC_BODY" >> "$LOG_FILE"
echo "App Name: $SWAYNC_APP_NAME" >> "$LOG_FILE"

# 1. Tentar extrair uma URL
URL=$(echo "$SWAYNC_BODY $SWAYNC_SUMMARY" | grep -oP "https?://\S+" | head -n 1)
if [ -n "$URL" ]; then
    echo "Abrindo URL: $URL" >> "$LOG_FILE"
    xdg-open "$URL"
    exit 0
fi

# 2. Tentar extrair um comando de workspace (ex: "workspace:3")
WS=$(echo "$SWAYNC_BODY $SWAYNC_SUMMARY" | grep -oP "workspace:\d+" | head -n 1 | cut -d: -f2)
if [ -n "$WS" ]; then
    echo "Mudando para workspace: $WS" >> "$LOG_FILE"
    # Adicionando variáveis de ambiente do Hyprland caso necessário
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
    hyprctl dispatch workspace "$WS" >> "$LOG_FILE" 2>&1
    exit 0
fi

# 3. Foco em Apps
if [ -n "$SWAYNC_APP_NAME" ] && [ "$SWAYNC_APP_NAME" != "notify-send" ]; then
    echo "Focando no app: $SWAYNC_APP_NAME" >> "$LOG_FILE"
    hyprctl dispatch focuswindow "class:($SWAYNC_APP_NAME)" >> "$LOG_FILE" 2>&1
fi
