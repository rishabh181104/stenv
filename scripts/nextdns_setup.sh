#!/bin/bash

# Exit on any error
set -e

# Log file for debugging
LOG_FILE="/tmp/optimize_network.log"
exec 1> >(tee -a "$LOG_FILE")
exec 2>&1

# Function to log messages
log_message() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $1"
}

# Function to log errors and exit
log_error() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1"
  exit 1
}

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check for required commands
for cmd in nmcli iw firewall-cmd; do
  if ! command_exists "$cmd"; then
    log_error "$cmd is not installed. Install it with 'sudo zypper install $cmd'."
  fi
done

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
  log_error "This script must be run as root (use sudo)."
fi

# Get active Wi-Fi and Ethernet connections
wifi_info=$(nmcli -t -f NAME,DEVICE,TYPE con show --active | grep wifi || true)
eth_info=$(nmcli -t -f NAME,DEVICE,TYPE con show --active | grep ethernet || true)

wifi_conn=""
wifi_dev=""
eth_conn=""
eth_dev=""

if [ -n "$wifi_info" ]; then
  wifi_conn=$(echo "$wifi_info" | cut -d: -f1)
  wifi_dev=$(echo "$wifi_info" | cut -d: -f2)
fi

if [ -n "$eth_info" ]; then
  eth_conn=$(echo "$eth_info" | cut -d: -f1)
  eth_dev=$(echo "$eth_info" | cut -d: -f2)
fi

# Check if any connections are active
if [ -z "$wifi_conn" ] && [ -z "$eth_conn" ]; then
  log_message "No active Wi-Fi or Ethernet connections found."
  exit 0
fi

# Configure Wi-Fi settings
if [ -n "$wifi_conn" ]; then
  log_message "Configuring Wi-Fi connection: $wifi_conn (device: $wifi_dev)"

    # Disable Wi-Fi power saving
    if iw dev "$wifi_dev" set power_save off 2>/dev/null; then
      log_message "Disabled Wi-Fi power saving for $wifi_dev"
    else
      log_message "Failed to disable power saving for $wifi_dev (may not be supported)"
    fi

    # Make power saving disable permanent (for Intel Wi-Fi)
    if lsmod | grep -q iwlwifi; then
      echo "options iwlwifi power_save=0" > /etc/modprobe.d/iwlwifi.conf
      log_message "Set permanent Wi-Fi power saving disable in /etc/modprobe.d/iwlwifi.conf"
    else
      log_message "No iwlwifi module detected; skipping permanent power save config"
    fi

    # Set public DNS servers
    nmcli connection modify "$wifi_conn" ipv4.dns "45.90.28.214,45.90.30.214" || log_error "Failed to set IPv4 DNS for $wifi_conn"
    nmcli connection modify "$wifi_conn" ipv6.dns "2a07:a8c0::de:7d44,2a07:a8c1::de:7d44" || log_error "Failed to set IPv6 DNS for $wifi_conn"
    log_message "Set public DNS servers for $wifi_conn"
  else
    log_message "No active Wi-Fi connection found."
fi

# Configure Ethernet settings
if [ -n "$eth_conn" ]; then
  log_message "Configuring Ethernet connection: $eth_conn (device: $eth_dev)"

    # Set public DNS servers
    nmcli connection modify "$eth_conn" ipv4.dns "8.8.8.8,1.1.1.1" || log_error "Failed to set IPv4 DNS for $eth_conn"
    nmcli connection modify "$eth_conn" ipv6.dns "2001:4860:4860::8888,2606:4700:4700::1111" || log_error "Failed to set IPv6 DNS for $eth_conn"
    log_message "Set public DNS servers for $eth_conn"
  else
    log_message "No active Ethernet connection found."
fi

# Configure firewall to allow ICMP
log_message "Configuring firewall to allow ICMP"
if firewall-cmd --add-protocol=icmp --permanent >/dev/null && firewall-cmd --reload >/dev/null; then
  log_message "ICMP protocol allowed in firewall"
else
  log_message "Failed to configure firewall; check firewalld status"
fi

# Restart NetworkManager to apply changes
log_message "Restarting NetworkManager"
if systemctl restart NetworkManager >/dev/null; then
  log_message "NetworkManager restarted successfully"
else
  log_error "Failed to restart NetworkManager"
fi

# Wait for connections to reactivate
sleep 3

# Reactivate connections
if [ -n "$wifi_conn" ]; then
  if nmcli connection up "$wifi_conn" >/dev/null; then
    log_message "Reactivated Wi-Fi connection: $wifi_conn"
  else
    log_message "Failed to reactivate $wifi_conn"
  fi
fi
if [ -n "$eth_conn" ]; then
  if nmcli connection up "$eth_conn" >/dev/null; then
    log_message "Reactivated Ethernet connection: $eth_conn"
  else
    log_message "Failed to reactivate $eth_conn"
  fi
fi

# Test connectivity
log_message "Testing connectivity with ping"
ping -c 4 8.8.8.8 || log_message "Ping test failed; check network status"

log_message "Network optimization complete! Log saved to $LOG_FILE"
