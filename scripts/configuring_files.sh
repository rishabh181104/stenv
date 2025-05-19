#!/bin/bash

# Base paths
SOURCE_BASE="$HOME/stenv"
TARGET_BASE="$HOME/.config"
HOME_BASE="$HOME"

# List of directories to replace
DIRS_TO_REPLACE=("ghostty" "wal" "fastfetch" "foot" "kitty" "nvim" "wlogout" "fish" "hypr" "mako" "rofi" "waybar" "i3" "i3status" "picom" "qutebrowser" "dunst")

# List of files to replace
FILES_TO_REPLACE=("starship.toml")

# List of files to replace in the home dir
FILES_TO_REPLACE_IN_HOME_DIR=(".xinitrc")

# === Replace Directories ===
echo "🔁 Replacing Directories..."
for DIR_NAME in "${DIRS_TO_REPLACE[@]}"; do
  SRC="$SOURCE_BASE/$DIR_NAME"
  DEST="$TARGET_BASE/$DIR_NAME"

  if [ ! -d "$SRC" ]; then
    echo "❌ Source directory does not exist: $SRC"
    continue
  fi

  if [ -d "$DEST" ]; then
    echo "🗑️ Removing existing directory: $DEST"
    rm -rf "$DEST"
  fi

  echo "📁 Copying $SRC to $TARGET_BASE"
  ln -s "$SRC" "$TARGET_BASE"
done

# === Replace Files ===
echo "🔁 Replacing Files..."
for FILE_NAME in "${FILES_TO_REPLACE[@]}"; do
  SRC="$SOURCE_BASE/$FILE_NAME"
  DEST="$TARGET_BASE/$FILE_NAME"

  if [ ! -f "$SRC" ]; then
    echo "❌ Source file does not exist: $SRC"
    continue
  fi

  if [ -f "$DEST" ]; then
    echo "🗑️ Removing existing file: $DEST"
    rm -f "$DEST"
  fi

  echo "📄 Copying $SRC to $TARGET_BASE"
  ln -s "$SRC" "$TARGET_BASE"

done

# ===Replacing files in home folder===
echo "🔁 Replacing Files..."
for FILE_NAME in "${FILES_TO_REPLACE_IN_HOME_DIR[@]}"; do
  SRC="$SOURCE_BASE/$FILE_NAME"
  HOM="$HOME_BASE/$FILE_NAME"

  if [ ! -f "$SRC" ]; then
    echo "❌ Source file does not exist: $SRC"
    continue
  fi

  if [ -f "$HOM" ]; then
    echo "🗑️ Removing existing file: $HOM"
    rm -f "$HOM"
  fi

  echo "📄 Copying $SRC to $HOME_BASE"
  ln -s "$SRC" "$HOME_BASE"
done

echo "✅ All done."
