#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print a separator line
print_separator() {
	echo -e "${PURPLE}════════════════════════════════════════════════════════════════════════════════${NC}"
}

# Function to print a header
print_header() {
	echo -e "\n${PURPLE}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
	echo -e "${PURPLE}║${WHITE} $1${PURPLE}║${NC}"
	echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════════════════╝${NC}\n"
}

# Function to print a success message
print_success() {
	echo -e "${GREEN}✓ $1${NC}"
}

# Function to print a warning message
print_warning() {
	echo -e "${YELLOW}⚠ $1${NC}"
}

# Function to print an error message
print_error() {
	echo -e "${RED}✗ $1${NC}"
}

# Function to check if a command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Clear screen
clear

# Check if running as root
if [ "$EUID" -eq 0 ]; then
	print_error "Please do not run this script as root"
	exit 1
fi

# Check if zypper exists
if ! command_exists zypper; then
	print_error "zypper package manager not found. This script is for openSUSE systems."
	exit 1
fi

# ASCII Art with enhanced colors
echo -e "${PURPLE}"
cat << "EOF"
╔════════════════════════════════════════════════════════════════════════════╗
║  _    _           _                 _                 _                    ║
║ | |  | |         | |               | |               | |                   ║
║ | |__| |_   _  __| |_ __ __ _ _ __ | |__   __ _ _ __| |                   ║
║ |  __  | | | |/ _` | '__/ _` | '_ \| '_ \ / _` | '__| |                   ║
║ | |  | | |_| | (_| | | | (_| | |_) | | | | (_| | |  |_|                   ║
║ |_|  |_|\__, |\__,_|_|  \__,_| .__/|_| |_|\__,_|_|  (_)                   ║
║         __/ |               | |                                          ║
║        |___/                |_|                                          ║
╚════════════════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

print_header "Hyprland Setup Script"
echo -e "${WHITE}This script will install and configure Hyprland and its dependencies.${NC}\n"

# Function to show spinner with enhanced visuals
spinner() {
	local pid=$1
	local delay=0.1
	local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
	local i=0
	while kill -0 $pid 2>/dev/null; do
		local temp=${spinstr:$i:1}
		printf " ${PURPLE}[${WHITE}%s${PURPLE}]${NC}  " "$temp"
		i=$(( (i+1) % 10 ))
		sleep $delay
		printf "\b\b\b\b\b\b"
	done
	printf "    \b\b\b\b"
}

# Function to show progress bar with enhanced visuals
progress_bar() {
	local duration=$1
	local steps=50
	local step=$((duration / steps))
	local progress=0

	printf "${PURPLE}[${WHITE}"
	for ((i=0; i<steps; i++)); do
		printf " "
	done
	printf "${PURPLE}]${NC}"

	for ((i=0; i<steps; i++)); do
		sleep $step
		printf "\r${PURPLE}[${WHITE}"
		for ((j=0; j<i; j++)); do
			printf "█"
		done
		printf "▌"
		for ((j=i+1; j<steps; j++)); do
			printf " "
		done
		printf "${PURPLE}]${NC}"
	done
	printf "\n"
}

# List of packages to install
PACKAGES=(
	hyprland
	hypridle
	hyprland-qt-support
	hyprland-qtutils
	hyprlock
	hyprpicker
	libhyprcursor0
	libhyprgraphics0
	libhyprlang2
	libhyprutils4
	xdg-desktop-portal-hyprland
	xdg-desktop-portal-wlr
	xdg-desktop-portal
	grim
	slurp
	waybar
	NetworkManager
	NetworkManager-applet
	swww
	blueman
	google-noto-coloremoji-fonts
	emojione-color-fonts
	fastfetch
	foot
	fish
	xwayland
	kitty
	mako
	neovim
	rofi
	starship
	wlogout
	wl-clipboard
	libwlroots
	git
	cargo
	rustup
	go
	nodejs
	npm
	brightnessctl
	pavucontrol
)

# Function to install packages
install_packages() {
	print_header "Updating Package List"
	if ! sudo zypper refresh; then
		print_error "Failed to update package list"
		exit 1
	fi
	print_success "Package list updated successfully"

	print_header "Installing Packages"
	print_warning "This may take a while. Please be patient..."
	progress_bar 5 &
	if ! sudo zypper install -y "${PACKAGES[@]}"; then
		print_error "Failed to install packages"
		exit 1
	fi
	wait

	print_success "All packages installed successfully"
	print_header "Installation Complete"
	echo -e "${WHITE}Your system is now ready to rock! 🚀${NC}"
	echo -e "${PURPLE}Thank you for using the Hyprland Setup Script!${NC}"
	print_separator
}

# Run installation
install_packages
