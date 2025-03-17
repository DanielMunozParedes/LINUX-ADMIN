# **Sentinel - Automated Linux Server Security & Monitoring**  

> *Project #1 of my Linux Administration & Security portfolio.*  
> *This is part of my hands-on journey in cybersecurity and server hardening. Built from scratch, it demonstrates real-world security skills while remaining open to improvements and feedback.*  

**Sentinel** is a **lightweight, automated security system** designed to **harden Linux servers, monitor logs, and send real-time alerts** when threats are detected. It integrates **fail2ban, UFW, and custom scripts** for active protection against attacks.  

---

**Features**  

**Automated Security Hardening** – Configures **SSH, firewall (UFW), and fail2ban** automatically.  

**Intrusion Detection & Log Monitoring** – Real-time monitoring of logs for brute force attempts and unusual activity. 

**Telegram Alerts** – Sends instant security notifications to your phone when suspicious activity is detected.  

**Custom Firewall Rules** – Dynamically adjusts firewall settings based on detected threats.  

**Attack Simulation Scripts** – Test your security setup by simulating real-world cyber attacks.  

---

**Demo Screenshots**  

| **Sentinel Monitoring Dashboard** | **Telegram Alert Example** |
|----------------------------------|---------------------------|
| ![Monitoring](screenshots/monitoring_dashboard.png) | ![Alert](screenshots/alert_example.png) |

---

**How It Works**  

🔹 **Log Analysis** – Monitors `/var/log/auth.log` and `/var/log/syslog` for suspicious activity.  
🔹 **Automated Actions** – If an attack is detected, Sentinel can:  
   - Block the attacker’s IP with **UFW**.  
   - Add the attacker to **Fail2Ban’s blocklist**.  
   - Send a **Telegram alert** with details.  
🔹 **Attack Simulations** – Test security by running a simulated attack (`simulate_attack.sh`).  

---

**Project Structure**  
Sentinel-Project/ 
│── README.md # Project overview 

│── LICENSE # Open-source license 

│── docs/ # Detailed documentation

│── config/ # Security configurations 

│── scripts/ # Security automation scripts 

│── tests/ # Attack simulation & testing 

│── logs/ # Example logs for analysis 

│── screenshots/ # Project images


---

**Future Roadmap**  

🚧 **Phase 2**: AI-based anomaly detection for advanced threat analysis.  
🚧 **Phase 3**: Web dashboard for real-time security visualization.  
🚧 **Phase 4**: Custom plugins for different Linux environments.  

---

**A Self-Taught Journey in Cybersecurity**  

This project is part of my **self-taught** learning path in **Linux security and automation**. I’ve built Sentinel to **apply real-world cybersecurity concepts**—but also as a way to **push myself, learn from the community, and continuously improve**.  

**To recruiters and hiring managers:** I’m not just learning—I’m actively building, breaking, and securing systems. **Sentinel is proof of my hands-on expertise.**  

**To the community:** I welcome feedback, suggestions, and improvements! If you see ways to make Sentinel better, I’d love to collaborate.  




 **Contact & Contributions**  

💬 **Want to improve Sentinel?** PRs and contributions are welcome!  
📧 **Have questions?** Open an issue or contact me at **danielmunozparedes@gmail.com**  

