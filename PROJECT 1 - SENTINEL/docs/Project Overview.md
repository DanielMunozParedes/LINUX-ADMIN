# Sentinel - Linux Security Hardening & Intrusion Detection  

## Project Overview  

**Sentinel** is a hands-on cybersecurity project designed to **harden Linux servers** against attacks and implement **automated intrusion detection**. The goal is to simulate **real-world security threats** while demonstrating **effective defense mechanisms** that can be applied in enterprise environments.  

This project is part of my **Linux Administration & Security series**, showcasing my self-taught journey in cybersecurity. While I have built Sentinel as a learning experience, it follows industry best practices and can be expanded into a real-world defensive solution.  

---

## Why This Project?  

🔹 **Linux servers are prime targets** – Attackers constantly scan for misconfigurations, weak SSH credentials, and outdated software.  
🔹 **Proactive security matters** – Most intrusions go undetected until it's too late. This project demonstrates **automated alerting and mitigation**.  
🔹 **Showcasing technical skills** – Sentinel is a **real-world, applicable security solution** that recruiters and professionals can assess.  

---

## Key Features  

✅ **Automated Hardening** – Secure SSH configurations, firewall rules, and Fail2Ban policies  
✅ **Intrusion Detection** – Real-time log monitoring to detect suspicious activity  
✅ **Honeypot Simulation** – Trick attackers into revealing their techniques  
✅ **Automated Alerts** – Send notifications (e.g., Telegram) when an attack is detected  
✅ **Log Analysis & Forensics** – Collect and analyze system logs for security insights  

---

## Realistic Attack & Defense Simulation  

Sentinel is structured around a **realistic attack scenario**, documented in **[02_storyline.md](02_storyline.md)**. It follows an attacker's **attempted breach**, the security system's **response**, and how logs & automation detect the intrusion.  

**Attack Scenario:**  
🛑 Brute-force SSH attack → Triggering Fail2Ban  
🎭 Attacker interacts with a honeypot → Logging suspicious behavior  
🚨 Automated alert sent to the administrator  

---

## 📂 Project Structure  

📁 **docs/** – Project documentation, attack scenarios, and analysis  
📁 **config/** – Configuration files (SSH, firewall, Fail2Ban, etc.)  
📁 **scripts/** – Automation scripts for security monitoring and alerts  
📁 **logs/** – Example logs to demonstrate attack detection  

---

## 🔧 Setting Up Sentinel  

To try out this project, see **[04_environment-setup.md](04_environment-setup.md)** for installation and configuration instructions.  

