#!/bin/bash

# Ensure pywal16 environment is active
if [ -z "$VIRTUAL_ENV" ]; then
  source ~/pywal16-env/bin/activate
fi

# Set wallpaper directory and fallback
WALLPAPER_DIR="$HOME/Wallpapers/Pictures/"
FALLBACK_WALLPAPER="$HOME/Wallpapers/Pictures/Mountain.png"

# Create wallpaper directory if it doesn't exist
if [ ! -d "$WALLPAPER_DIR" ]; then
  mkdir -p "$WALLPAPER_DIR"
  if [ ! -f "$FALLBACK_WALLPAPER" ]; then
    curl -o "$FALLBACK_WALLPAPER" https://raw.githubusercontent.com/JaKooLit/Wallpaper-Bank/main/Wallpapers/4K/Blue-Purple.png
  fi
fi

# Select random wallpaper or fallback
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
if [ -z "$WALLPAPER" ]; then
  WALLPAPER="$FALLBACK_WALLPAPER"
fi

# Apply pywal16 theme
wal -i "$WALLPAPER"

# Apply wallpaper and reload based on session
case "$XDG_SESSION_TYPE" in
  "wayland")
    # Hyprland with swww
    if command -v swww >/dev/null 2>&1; then
      swww img "$WALLPAPER" --transition-type wipe
    else
      echo "swww not found. Install with 'sudo zypper install swww'."
    fi
    ;;
  "x11")
    # i3 or dwm with feh
    if command -v feh >/dev/null 2>&1; then
      feh --bg-scale "$WALLPAPER"
      if pgrep i3 >/dev/null; then
        i3-msg reload
      fi
    else
      echo "feh not found. Install with 'sudo zypper install feh'."
    fi
    ;;
  *)
    echo "Unknown session type: $XDG_SESSION_TYPE"
    ;;
esac

echo "Theme applied with wallpaper: $WALLPAPER"
