# Sentinel - Project Requirements  

##  Introduction  

Sentinel is a **Linux security automation framework** designed to **protect critical infrastructure** from unauthorized access, brute-force attacks, and misconfigurations.  

This document outlines the **security needs of the simulated company**, the **rationale for Sentinel's design choices**, and how it fulfills those requirements.  

---

## **Company Context & Security Needs**  

The organization operates **Linux-based servers** exposed to the internet, handling:  
- **Internal applications** (databases, web services).  
- **Remote administration** (SSH access for sysadmins).  
- **Sensitive customer data** (requires strict security measures).  

### **Security Challenges**  
1️⃣ **Frequent unauthorized SSH access attempts** from external sources.  
2️⃣ **Potential data breaches** due to weak authentication policies.  
3️⃣ **Need for real-time monitoring & alerts** to detect suspicious activity.  
4️⃣ **Compliance with cybersecurity best practices** (firewall rules, logs, intrusion detection).  

---

##  **Why Sentinel? (Project Justification)**  

Sentinel was developed to **automate and enhance security** through:  

✅ **Fail2Ban Integration** – Blocks IPs after multiple failed login attempts.  
✅ **Firewall Hardening (UFW)** – Restricts access to critical services.  
✅ **Honeypots for Threat Intelligence** – Lures attackers into fake services to collect data.  
✅ **Real-Time Telegram Alerts** – Notifies administrators instantly about suspicious activity.  
✅ **Automated Log Analysis** – Continuously scans logs for security events.  

---

## **Core Security Features & Components**  

| Feature            | Purpose  | Implementation |
|--------------------|---------|---------------|
| **Fail2Ban**       | Blocks repeated login failures | Monitors `/var/log/auth.log` |
| **UFW Firewall**   | Restricts unauthorized access | Only whitelisted IPs allowed |
| **Honeypots**      | Detects attacker behavior | Fake SSH service on high ports |
| **Log Monitoring** | Detects anomalies | Python scripts parse logs |
| **Telegram Alerts** | Instant notifications | Alerts on security events |
| **Automation Scripts** | Simplifies deployment | Shell & Python scripts |

---

##  **Project Goals & Expected Outcomes**  

📌 **Enhance server security** by proactively blocking threats.  
📌 **Reduce false positives** in security alerts.  
📌 **Collect attacker intelligence** using honeypots.  
📌 **Provide a scalable security framework** for future improvements.  

