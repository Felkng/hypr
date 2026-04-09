#!/bin/bash
# Smart close: toggle Spotify (minimize to special), kill other windows
class=$(hyprctl activewindow -j | jq -r .class)
if [[ "${class,,}" == "spotify" ]]; then
    /home/felkng/.local/bin/spotify-toggle.sh
else
    hyprctl dispatch killactive
fi
