#!/bin/bash
set -e
# Start swww-daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
	swww-daemon &
	sleep 1
fi
# Set wallpaper directory
WALLPAPER_DIR="$HOME/Wallpapers/Pictures"
# Select a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
if [ -n "$WALLPAPER" ]; then
	# Set wallpaper with swww
	swww img "$WALLPAPER" --transition-type random --transition-fps 30 || {
		echo "Failed to set wallpaper with swww"
			exit 1
		}
	# Generate and apply wallust colors
	wallust run "$WALLPAPER" || {
		echo "Failed to run wallust. Check ~/.config/wallust/wallust.toml and templates"
			exit 1
		}
	# Reload Sway to apply colors
	swaymsg reload || echo "Failed to reload Sway configuration"
else
	echo "No wallpapers found in $WALLPAPER_DIR"
	exit 1
fi
