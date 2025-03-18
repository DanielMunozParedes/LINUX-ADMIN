# Configuration Files  

This document contains essential security configurations for Sentinel v0.  

## 🔹 SSH Security (`/etc/ssh/sshd_config`)  
Disable root login and enforce key-based authentication.  
```plaintext
PermitRootLogin no  
PasswordAuthentication no  
AllowUsers your-user  
