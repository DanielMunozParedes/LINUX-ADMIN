#!/bin/bash

 

LOG_FILE="/var/log/sentinel_lite.log"
INSTALL_FLAG="/etc/sentinel_lite_installed"

# Function to log actions
log_action() {
    echo "$(date) - $1" | tee -a "$LOG_FILE"
}

# Check if script has already been run
if [ -f "$INSTALL_FLAG" ]; then
    log_action "Sentinel Lite has already been installed. Exiting."
    exit 0
fi

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    log_action "Please run this script as root."
    exit 1
fi

log_action "Starting Sentinel Lite security setup..."

# System Update & Upgrade
log_action "Updating and upgrading system packages..."
apt update && apt upgrade -y

#  SSH Hardening - Disable Root Login
log_action "Hardening SSH: Disabling root login..."
sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd
log_action "SSH hardened and restarted."

# Install & Configure Fail2Ban
log_action "Installing Fail2Ban..."
apt install -y fail2ban

log_action "Configuring Fail2Ban jail..."
cat <<EOL > /etc/fail2ban/jail.local
[sshd]
enabled = true
bantime = 10m
findtime = 10m
maxretry = 3
EOL
systemctl restart fail2ban
log_action "Fail2Ban installed and restarted."

# Install & Configure Honeypot (Honeyd)
log_action "Installing Honeyd..."
apt install -y honeyd

log_action "Configuring Honeyd..."
cat <<EOL > /etc/honeyd.conf
create fake-ssh
set fake-ssh personality "Linux 2.6"
set fake-ssh openports 2222
bind 192.168.0.2 fake-ssh
EOL

systemctl restart honeyd
log_action "Honeypot (Honeyd) installed and restarted."

# Mark script as installed
touch "$INSTALL_FLAG"
log_action "Sentinel Lite security setup completed!"

exit 0
