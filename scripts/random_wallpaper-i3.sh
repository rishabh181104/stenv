#!/bin/bash
set -e

# Set wallpaper directory
WALLPAPER_DIR="$HOME/Wallpapers/Pictures"

# Select a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)

if [ -n "$WALLPAPER" ]; then
  # Set wallpaper with feh
  feh --bg-fill "$WALLPAPER" || {
    echo "Failed to set wallpaper with feh"
      exit 1
    }

    # Generate and apply wallust colors
    wallust run "$WALLPAPER" || {
      echo "Failed to run wallust. Check ~/.config/wallust/wallust.toml and templates"
          exit 1
        }

    # Reload i3 to apply colors
    i3-msg reload || echo "Failed to reload i3 configuration"
  else
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi
