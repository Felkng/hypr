#!/bin/bash
# Localização dos wallpapers (prioriza ~/Pictures/Wallpapers e inclui ~/Downloads)
WP_DIRS=("$HOME/Pictures/Wallpapers" "$HOME/Downloads")

FILES=()
for dir in "${WP_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        while IFS= read -r file; do
            [ -n "$file" ] && FILES+=("$file")
        done < <(find "$dir" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \))
    fi
done

if [ ${#FILES[@]} -eq 0 ]; then
    notify-send -u normal "Wallpaper Picker" "Nenhum wallpaper encontrado em ~/Pictures/Wallpapers ou ~/Downloads."
    exit 0
fi

declare -A FILE_MAP
MENU_ITEMS=""
for f in "${FILES[@]}"; do
    base=$(basename "$f")
    FILE_MAP["$base"]="$f"
    MENU_ITEMS+="$base"$'\n'
done

SELECTED=$(echo -n "$MENU_ITEMS" | sed '/^$/d' | sort -u | walker --dmenu)

if [ -n "$SELECTED" ] && [ -n "${FILE_MAP[$SELECTED]}" ]; then
    TARGET_PATH="${FILE_MAP[$SELECTED]}"
    waypaper --wallpaper "$TARGET_PATH"
    notify-send -u low "Wallpaper Aplicado" "O wallpaper foi alterado para: $SELECTED"
fi
