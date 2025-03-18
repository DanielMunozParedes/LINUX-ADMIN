#!/bin/bash

# Sentinel - Linux Security & Monitoring Automation Script
# Created by: Daniel Muñoz Paredes
# Version: 0.1 - Unstable, need to fix If run twice, it overwrites Loki & Grafana settings.

LOG_FILE="/var/log/sentinel.log"
INSTALL_FLAG="/etc/sentinel_installed"

# Function to log actions
log_action() {
    echo "$(date) - $1" | tee -a "$LOG_FILE"
}

# Check if script has already been run
if [ -f "$INSTALL_FLAG" ]; then
    log_action "Sentinel has already been installed. Exiting."
    exit 0
fi

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    log_action "Please run this script as root."
    exit 1
fi

# Prompt user for required inputs
read -p "Enter server IP address: " SERVER_IP
read -s -p "Enter new password for Loki/Grafana: " SECURE_PASSWORD
echo ""

log_action "Starting Sentinel security configuration..."

# Update and upgrade system
log_action "Updating system packages..."
apt update && apt upgrade -y

# Install security tools
log_action "Installing Fail2Ban, UFW, and other security packages..."
apt install -y fail2ban ufw unattended-upgrades

# Configure Firewall (UFW)
log_action "Configuring UFW firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 3000  # Grafana
ufw allow 3100  # Loki
ufw enable

# Configure Fail2Ban
log_action "Configuring Fail2Ban..."
cat <<EOL > /etc/fail2ban/jail.local
[sshd]
enabled = true
bantime = 10m
findtime = 10m
maxretry = 3
EOL
systemctl restart fail2ban

# Install Docker & Docker-Compose
log_action "Installing Docker & Docker-Compose..."
apt install -y docker.io docker-compose
systemctl enable --now docker

# Deploy Loki & Grafana
log_action "Deploying Loki & Grafana with security settings..."
mkdir -p /opt/monitoring
cat <<EOL > /opt/monitoring/docker-compose.yml
version: '3.8'
services:
  loki:
    image: grafana/loki:latest
    ports:
      - "3100:3100"
    volumes:
      - /opt/monitoring/loki-config.yml:/etc/loki/local-config.yaml
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=$SECURE_PASSWORD
    volumes:
      - grafana_data:/var/lib/grafana
volumes:
  grafana_data:
EOL
docker-compose -f /opt/monitoring/docker-compose.yml up -d

# Secure Loki/Grafana
log_action "Securing Grafana & Loki..."
useradd -r -s /bin/false grafana
chown -R grafana:grafana /opt/monitoring
chmod -R 750 /opt/monitoring

# Discord Notifications (Optional)
read -p "Do you want to enable Discord notifications? (y/n): " DISCORD_CHOICE
if [[ "$DISCORD_CHOICE" =~ ^[Yy]$ ]]; then
    read -p "Enter Discord Webhook URL: " DISCORD_WEBHOOK
    cat <<EOL > /opt/monitoring/discord_notify.sh
#!/bin/bash
curl -H "Content-Type: application/json" -X POST -d '{"content": "Sentinel has completed security setup."}' $DISCORD_WEBHOOK
EOL
    chmod +x /opt/monitoring/discord_notify.sh
    bash /opt/monitoring/discord_notify.sh
    log_action "Discord notifications enabled."
fi

# Create flag file to prevent reinstallation
touch "$INSTALL_FLAG"

# Display summary of changes
log_action "Sentinel Security Hardening Completed!"
log_action "Firewall configured, Fail2Ban enabled, Loki/Grafana deployed."
log_action "Check logs at $LOG_FILE"

exit 0
