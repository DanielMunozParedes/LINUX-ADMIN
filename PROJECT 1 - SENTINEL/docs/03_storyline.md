# Sentinel Project - Storyline

## **The Attacker’s Journey**

### **Phase 1: Reconnaissance**
A threat actor, “Ghost,” scans the internet for exposed SSH servers. He identifies a target running SSH on port 22 and gathers intel using **Nmap**, **Shodan**, and **Whois Lookup**.

### **Phase 2: Exploitation Attempt**
Ghost attempts an SSH brute-force attack using Hydra. However, **Fail2Ban** detects multiple failed logins and bans his IP. Additional security layers, including **UFW** and **port knocking**, further limit unauthorized access.

### **Phase 3: The Honeypot Trap**
Determined, Ghost exploits what appears to be a misconfigured system—unaware it's a **honeypot** . His every action is logged, alerting the administrator in real time.

### **Phase 4: Detection & Response**
The Sentinel system:
- **Sends real-time alerts** via Telegram.
- **Logs attacker activity** for analysis.
- **Deploys dynamic firewall rules** to block further attempts.

### **Phase 5: Lessons Learned**
This attack highlights the importance of:
- **Proactive hardening** (Fail2Ban, firewall rules, SSH best practices).
- **Early threat detection** via honeypots.
- **Automated response** to minimize human intervention.

