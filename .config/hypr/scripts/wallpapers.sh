#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/wallpapers/"
CURRENT=$(awww query | head -n1 | grep -oP 'image: \K\S+')
WALLPAPER=$(fd -E "$(basename "$CURRENT")" . "$WALLPAPER_DIR" | shuf -n 1)
awww img "$WALLPAPER" --transition-fps 144 --transition-duration 1
