#!/bin/bash

# Script to build and apply Flat-Remix-GTK-Blue theme on openSUSE Tumbleweed

# Exit on any error
set -e

# Variables
THEME_NAME="Flat-Remix-GTK-Blue"
REPO_URL="https://github.com/daniruiz/flat-remix-gtk.git"
THEME_DIR="$HOME/.themes"
REPO_DIR="$HOME/flat-remix-gtk"

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to detect desktop environment
detect_desktop() {
  if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    echo "GNOME"
  elif [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
    echo "KDE"
  else
    echo "Unknown"
  fi
}

# Step 1: Install dependencies
echo "Installing dependencies..."
if ! command_exists git; then
  sudo pacman -S git
fi
if ! command_exists gsettings; then
  sudo pacman -S glib2-tools
fi

# Step 2: Clone the Flat-Remix-GTK repository
echo "Cloning Flat-Remix-GTK repository..."
if [ -d "$REPO_DIR" ]; then
  echo "Repository already exists. Pulling latest changes..."
  cd "$REPO_DIR"
  git pull
else
  git clone "$REPO_URL" "$REPO_DIR"
  cd "$REPO_DIR"
fi

# Step 3: Create themes directory and copy theme files
echo "Installing theme to $THEME_DIR..."
mkdir -p "$THEME_DIR"
cp -r Flat-Remix-GTK-Blue* "$THEME_DIR/"

# Step 4: Apply the theme based on desktop environment
DESKTOP=$(detect_desktop)
echo "Detected desktop environment: $DESKTOP"

case "$DESKTOP" in
  GNOME)
    echo "Applying theme to GNOME..."
    if ! command_exists gnome-tweaks; then
      echo "Installing gnome-tweaks..."
      sudo pacman -S gnome-tweaks
    fi
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
    echo "Theme applied. Open GNOME Tweaks to verify or make further adjustments."
    ;;
  KDE)
    echo "Applying theme to KDE Plasma..."
    # KDE uses ~/.config/gtk-3.0/settings.ini for GTK3 themes
    GTK_SETTINGS="$HOME/.config/gtk-3.0/settings.ini"
    if [ ! -f "$GTK_SETTINGS" ]; then
      mkdir -p "$HOME/.config/gtk-3.0"
      echo "[Settings]" > "$GTK_SETTINGS"
    fi
    sed -i "/gtk-theme-name/d" "$GTK_SETTINGS"
    echo "gtk-theme-name=$THEME_NAME" >> "$GTK_SETTINGS"
    echo "Theme applied. Open System Settings > Appearance > Application Style to verify."
    ;;
  *)
    echo "Unsupported desktop environment. Please apply the theme manually from your desktop settings."
    echo "Theme files are located in $THEME_DIR."
    exit 1
    ;;
esac

# Step 5: Cleanup
echo "Cleaning up..."
cd ..
rm -rf "$REPO_DIR"

echo "Installation and application of $THEME_NAME complete!"
echo "You may need to restart your session or reboot for the theme to take full effect."
