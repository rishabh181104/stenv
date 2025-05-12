#!/bin/bash

# Exit on any error
set -e

# Define variables
REPO_URL="https://gitlab.com/phoneybadger/pokemon-colorscripts.git"
CLONE_DIR="/tmp/pokemon-colorscripts"
INSTALL_SCRIPT="./install.sh"

# Check if git is installed
if ! command -v git &> /dev/null; then
  echo "Error: git is not installed. Please install git and try again."
  exit 1
fi

# Clone the repository
echo "Cloning pokemon-colorscripts repository..."
git clone "$REPO_URL" "$CLONE_DIR"

# Change to the cloned directory
cd "$CLONE_DIR"

# Check if install.sh exists
if [ ! -f "$INSTALL_SCRIPT" ]; then
  echo "Error: install.sh not found in the repository."
  exit 1
fi

# Make the install script executable
chmod +x "$INSTALL_SCRIPT"

# Run the install script
echo "Running pokemon-colorscripts installation..."
"$INSTALL_SCRIPT"

# Clean up: remove the cloned directory
echo "Cleaning up: removing $CLONE_DIR..."
cd /tmp
rm -rf "$CLONE_DIR"

# Verify installation
if command -v pokemon-colorscripts &> /dev/null; then
  echo "Installation successful! You can now use 'pokemon-colorscripts'."
  echo "Try running: pokemon-colorscripts --random"
else
  echo "Error: Installation failed. Please check the output for errors."
  exit 1
fi
