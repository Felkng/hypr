#!/bin/bash

# Get Spotify window info (take the first one if multiple)
spotify_info=$(hyprctl clients -j | jq -r '.[] | select(.class == "Spotify") | limit(1; .)')

# If Spotify window doesn't exist, try to launch it (letting the tray handle it is better, but this is a fallback)
if [ -z "$spotify_info" ] || [ "$spotify_info" == "null" ]; then
    spotify &
    exit 0
fi

# Get current workspace and Spotify window address/workspace
current_workspace=$(hyprctl activeworkspace -j | jq -r .id)
spotify_addr=$(echo "$spotify_info" | jq -r .address)
spotify_workspace=$(echo "$spotify_info" | jq -r .workspace.id)
spotify_workspace_name=$(echo "$spotify_info" | jq -r .workspace.name)

# If it's in a special workspace (id < 0 or name starts with special:), move to current
if [[ "$spotify_workspace" -lt 0 ]] || [[ "$spotify_workspace_name" == special:* ]]; then
    hyprctl dispatch movetoworkspace "$current_workspace,address:$spotify_addr"
    hyprctl dispatch focuswindow "address:$spotify_addr"
else
    # If it's in a normal workspace, move to special (minimize)
    hyprctl dispatch movetoworkspacesilent special:spotify,address:$spotify_addr
fi
