# Sentinel - Linux Security & Monitoring Automation Script  

## Overview  
Sentinel is a **Bash automation script** designed to enhance **server security** by configuring **firewall rules, Fail2Ban, Loki, and Grafana**, while also providing optional **Discord notifications**.  This is subject to change and is aN unstable version so be aware when cloning this repo.

## Features  
- **Automated Security Hardening**: Updates system, installs security tools (Fail2Ban, UFW).  
- **Firewall Configuration**: Sets up UFW rules to restrict unauthorized access.  
- **Fail2Ban Protection**: Mitigates brute-force attacks by banning failed SSH login attempts.  
- **Loki & Grafana Deployment**: Sets up a logging and monitoring stack via **Docker**.  
- **Discord Webhook Notifications** *(Optional)*: Notifies a Discord server of the setup status.  
- **Prevention of Duplicate Installations**: Ensures Sentinel is only run once per system.  

## Requirements  
- **Ubuntu 24.04 LTS** or compatible Debian-based system  
- **Docker & Docker-Compose** (installed automatically)  
- **Root privileges** (sudo access required)  


