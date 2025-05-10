#!/bin/bash
cache_dir="$HOME/.cache/wallpapers/"

# Ensure cache directory exists
mkdir -p "$cache_dir"

# Get a list of connected monitor outputs
monitor_outputs=($(xrandr --current | grep " connected" | awk '{print $1}'))

# Initialize a flag to determine if the ln command was executed
ln_success=false

# Get the primary monitor (i3 typically uses the primary monitor for focus)
current_monitor=$(xrandr --current | grep " connected primary" | awk '{print $1}')
# Fallback to first connected monitor if no primary is found
[ -z "$current_monitor" ] && current_monitor=${monitor_outputs[0]}
echo $current_monitor

# Construct the full path to the cache file
cache_file="$cache_dir$current_monitor"
echo $cache_file

# Check if the cache file exists for the current monitor output
if [ -f "$cache_file" ]; then
  # Get the wallpaper path from the cache file
  wallpaper_path=$(head -n 1 "$cache_file")
  echo $wallpaper_path

  # Symlink the wallpaper to the location Rofi can access
  if ln -sf "$wallpaper_path" "$HOME/.config/rofi/.current_wallpaper"; then
    ln_success=true  # Set the flag to true upon successful execution
  fi

  # Copy the wallpaper for wallpaper effects (adjust path for i3)
  mkdir -p "$HOME/.config/i3/wallpaper_effects"
  cp -r "$wallpaper_path" "$HOME/.config/i3/wallpaper_effects/.wallpaper_current"
fi

# Check the flag before executing further commands
if [ "$ln_success" = true ]; then
  # Execute wallust (assuming wallust is used for color generation)
  echo 'about to execute wallust'
  # Execute wallust, skipping tty and terminal changes
  wallust run "$wallpaper_path" -s &
fi
