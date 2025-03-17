# Sentinel Project - Architecture Diagram

## **Overview**
This section provides a high-level diagram of the **Sentinel security system**, illustrating its components, interactions, and security layers.

## **Network & System Architecture**
The system consists of:
- **Target Server**: The main system under protection.
- **Attacker**: Kali Linux (External)
- **Users**: Multiple workstations connecting via SSH
- **Honeypot**: A decoy environment logging attacker actions.
- **Security Mechanisms**:
  - **Fail2Ban**: Blocks brute-force attacks.
  - **UFW Firewall**: Controls network access.
  - **Port Knocking**: Obfuscates SSH access.
- **Monitoring & Alerts**:
  - **Telegram Bot**: Sends real-time security alerts.
  - **Log Analysis**: Captures and reports suspicious activity.


 

| Component      | OS             | Role              | IP (Example)  |
|--------------|---------------|-----------------|--------------|
| **Attacker** | Kali Linux    | Simulated threat | 192.168.1.100 |
| **Server**   | Ubuntu Laptop | Target System    | 192.168.1.10  |
| **Honeypot** | Internal VM   | Decoy trap      | 192.168.1.11  |
| **Users**    | Various PCs   | Legitimate access | Dynamic       |


## **Diagram**
The following diagram illustrates the **Sentinel system's architecture** and security layers:

![sentinel_network_diagram](https://github.com/user-attachments/assets/e370bbc0-d572-4f5f-83a4-7d90246f9aa1)
