#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art
echo -e "${PURPLE}"
cat << "EOF"
  _    _           _                 _                 _ 
 | |  | |         | |               | |               | |
 | |__| |_   _  __| |_ __ __ _ _ __ | |__   __ _ _ __| |
 |  __  | | | |/ _` | '__/ _` | '_ \| '_ \ / _` | '__| |
 | |  | | |_| | (_| | | | (_| | |_) | | | | (_| | |  |_|
 |_|  |_|\__, |\__,_|_|  \__,_| .__/|_| |_|\__,_|_|  (_)
          __/ |               | |                        
         |___/                |_|                        
EOF
echo -e "${NC}"

# Animation characters
SPINNER=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')

# Function to show spinner
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

# Function to show progress bar
progress_bar() {
    local duration=$1
    local steps=50
    local step=$((duration / steps))
    local progress=0
    
    printf "${CYAN}["
    for ((i=0; i<steps; i++)); do
        printf " "
    done
    printf "]"
    
    for ((i=0; i<steps; i++)); do
        sleep $step
        printf "\r${CYAN}["
        for ((j=0; j<i; j++)); do
            printf "="
        done
        printf ">"
        for ((j=i+1; j<steps; j++)); do
            printf " "
        done
        printf "]"
    done
    printf "\n${NC}"
}

# List of packages to install
PACKAGES=(
	hyprland
	hyprlock
	wl-clipboard
	wf-recorder
	rofi-wayland
	rofi-network-manager
	libhyprlang2
	pavucontrol
	hyprland-qtutils
	wlogout
	dunst
	swaybg
	mpvpaper
	alacritty
	hyprcursor
	noto-fonts
	hyprpicker
	nwg-look
	jq
	gvfs
	mpv
	playerctl
	pamixer
	NetworkManager
	NetworkManager-applet
	neovim
	brightnessctl
	power-profiles-daemon
	waybar
	papirus-icon-theme
	starship
	grim
	slurp
	thunar
	ripgrep
	xdg-desktop-portal-wlr
	xdg-desktop-portal-hyprland
	xdg-desktop-portal
	xorg-x11
	dbus-1-daemon
	blueman
)

# Function to install packages
install_packages() {
    echo -e "${YELLOW}Updating package list...${NC}"
    (sudo zypper refresh) & spinner $!
    echo -e "\n${GREEN}✓ Package list updated${NC}"

    echo -e "\n${YELLOW}Installing packages...${NC}"
    echo -e "${BLUE}This may take a while...${NC}"
    progress_bar 5 &
    sudo zypper install -y "${PACKAGES[@]}" > /dev/null 2>&1
    wait

    echo -e "\n${GREEN}✓ Installation complete!${NC}"
    echo -e "${PURPLE}Your system is now ready to rock! 🚀${NC}"
}

# Run installation
install_packages
