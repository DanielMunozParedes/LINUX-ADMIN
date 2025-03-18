#  Linux Server Hardening Guide  

This document outlines the security measures implemented in Sentinel v0 for **server hardening** and **attack prevention**.  

 
## **1 - Enabling internet connection**
if we encounter that during the installation of the server the wifi or ethernet could not be setting by any scan error or fail, don't worry. Skip for now because the troubleshooting involves having Ubuntu Server installed.
We need to eanble the card that we wish to be set for the internet. You can see the name with the command
```bash
sudo ip a
```
 
```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:1a:2b:3c:4d:5e brd ff:ff:ff:ff:ff:ff

3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 11:22:33:44:55:66 brd ff:ff:ff:ff:ff:ff
```
 
setting the name of the card

```bash
sudo ip link set wlan0
```

If we encounter an error about RFKill is blocking we need to disable that "block". We need to find the path of the wifi card and check for the directory called phy80211 if the rfkill3 subfolder exist. then we change the line inside that file becasue the "soft" 
file returns a number binary response, so if returns 1 it means the lock is on so we change to 0. Next step is try again Sudo ip link set wlan0. For credits this problem was solved in the forum https://unix.stackexchange.com/a/763490
```bash
sudo find /sys/ -name "wlan0"

/sys/class/net/wificardname
ls /sys/class/net/wificadname/phy80211
rfkill3
sudo cat /sys/class/rfkill/rfkill3/soft
1
sudo echo 0 > /sys/class/rfkill/rfkill3/soft
```

now we bring up the network interface, we get an ip assingned by the dhclient and then we test with a ping.

```bash
sudo ip link set wificardname up
sudo dhclient wificardname
ping -c 4 8.8.8.8
```

## **2- System Updates, Upgrades and timezone**  
Ensuring all packages are up to date and we have a corrent timezone for log analysis.
```bash
sudo apt update && sudo apt upgrade -y
sudo timedatectl set-timezone <timeszone>
```
 
## **3- Securing SSH access**  
root only can acces onsite, but other users will use the service, so we need to secure it

we need a backup of the config ssh file, it is a good practice
```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
```

inside that file check the line "PermitRootLogin" is set to "no". Root can only be acces in the server. also we need to only allow the users that going to access, this practice reinforce the security of this protocol, and lastly we change the
port of the service in which is listened. why? we need to deceive and the attackers always know that ssh is listeng 22/tcp, but we can change it, besides this will work because the honeypot section will take advantage of this.

```bash
PermitRootLogin no  
AllowUsers user1 user2 
port 2222  
```

notify the firewall that we changed the port and we are lsitening in 2222/tcp, restart the service ssh and cheack the status if everithing is ok.

```bash
sudo ufw allow 2222/tcp
sudo systemctl restart ssh
sudo systemctl status ssh
```

 ## **4- User management**  
The only thing that is worth to take note here is that we need to create an admin user lite, still powerful but limited, so we need to change its group to have sudo privileges but not root priviliges
 
we need a backup of the config ssh file, it is a good practice
```bash
sudo adduser admin-lite
sudo usermod -aG sudo admin-lite
```

 ## **5- Firewall**
 Enable the firewall ,check and based on the services you have like PostgreSql you need to deny those to not be consumed by attackers.
 
```bash
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw deny 5432 #postgresql
```

also we can and need to configurate the firewall to allow only from certain ips we know. This ips are the users that are going to use ssh or any other service
```bash
sudo ufw allow from 127.0.0.1 to any port 5432 #if we are LAN and need some service to be consumed
sudo ufw allow from userip to any port 5432  
```
 ## **6- Fail2ban**
defense against brute force attacks and ban ips. Install,enable and create a jail for the config ban ip section
```bash
sudo apt install fail2ban
sudo systemctl enable fail2ban
sudo fail2ban -client status
sudo nano /etc/fail2ban/jail.local
```
we add this configuration params and we save and restart the service
```bash
[sshd]
 enabled = true
 bantime = 3600 #seconds banned
 maxretry = 3 #max loggin attemps tries


sudo systemctl restart fail2ban
```
 
