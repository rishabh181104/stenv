#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'

# Spinner for visual feedback
spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# Print functions
print_header() { echo -e "${BLUE}${BOLD}===> $1${NC}"; }
print_success() { echo -e "${GREEN}${BOLD}[✔] $1${NC}"; }
print_error() { echo -e "${RED}${BOLD}[✘] $1${NC}"; exit 1; }

# Banner
clear
echo -e "${YELLOW}${BOLD}"
echo "========================================="
echo "   Pywal16 Installer for Fish Shell"
echo "========================================="
echo -e "${NC}"
echo "Installing pywal16 in a virtual environment..."
echo

# Update package list and install dependencies
print_header "Updating package list and installing dependencies..."
sudo pacman -Syyu > /dev/null 2>&1 &
spinner $!
sudo pacman -Syu python python-pip python-virtualenv git imagemagick > /dev/null 2>&1 &
spinner $!
[ $? -eq 0 ] || print_error "Failed to install dependencies. Check your connection or permissions."

# Create and activate virtual environment
print_header "Creating virtual environment..."
rm -rf ~/pywal16-env  # Remove old env if it exists
python -m virtualenv ~/pywal16-env > /dev/null 2>&1 &
spinner $!
source ~/pywal16-env/bin/activate || print_error "Failed to activate virtual environment."

# Install pywal16
print_header "Installing pywal16 from GitHub..."
pip install --upgrade pip > /dev/null 2>&1
pip install git+https://github.com/eylles/pywal16.git --no-cache-dir > /dev/null 2>&1 &
spinner $!
[ $? -eq 0 ] || print_error "Failed to install pywal16. Check your connection."

# Verify installation
print_header "Verifying installation..."
if wal --version > /dev/null 2>&1; then
  print_success "pywal16 installed! Version: $(wal --version)"
else
  print_error "Installation verification failed."
fi

# Configure Fish shell
print_header "Configuring Fish shell..."
FISH_CONFIG="$HOME/.config/fish/config.fish"
mkdir -p "$(dirname "$FISH_CONFIG")"
if ! grep -q "pywal16-env" "$FISH_CONFIG"; then
  echo -e "\n# Activate pywal16 environment" >> "$FISH_CONFIG"
  echo "source ~/pywal16-env/bin/activate.fish" >> "$FISH_CONFIG"
  print_success "Fish shell configured."
else
  print_success "Fish shell already configured."
fi

# Final message
echo -e "${GREEN}${BOLD}🎉 Done! pywal16 is ready!${NC}"
echo "Run 'source ~/pywal16-env/bin/activate.fish' or open a new Fish terminal."
echo "Test it with: ${BLUE}wal -i /path/to/wallpaper.jpg${NC}"
