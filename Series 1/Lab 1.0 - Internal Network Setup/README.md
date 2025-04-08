# Objective
Configure an internal LAN with two VMs (VirtualBox Internal Network). THen it comes the setup for the ssh connection of those 2 machines. denying users remote connection and fixing ,potentially, common problems.



## Software
Oracle Virtual Box (V-7.1.6)

## OS
Ubuntu server and Linux GUI Machines. We'll need 2 machines (at least for now) one to simulate a server to be accessed via SSH and the client. For the server we are going to be using Ubuntu Server 24.10 ISO and for the client Kali 2025.1a (The decision of Kali as a client has nothing to do, at least for now, with security things or pentesting realated, but the need of a client with GUI so i choosed this because is Debian based and i can show some Network related troubleshouting)

---

# Contents

| Project | Description |
|---------|-------------|
| [Virtual box setup](https://github.com/DanielMunozParedes/LINUX-ADMIN/) | General overview, tips and internal network.|
| [Networking files config and testing ping](https://github.com/daniel/windows-threat-lab) | Networking files configuration for the machines. | 
| [ssh configuration](https://github.com/daniel/offensive-recon-lab) | configuration in each machine if needed for the ssh.  |
| [ssh permissions configuration](https://github.com/daniel/privilege-escalation-lab) | configuration and testing to assing permissions of connection ssh| 
| [Pentesting](https://github.com/daniel/python-alert-simulator) | (coming soon) | 
| [writeups-ctfs](https://github.com/daniel/writeups-ctfs) | Writeups and reflections from Bandit, picoCTF, and other CTF platforms. | 
| [Troubleshooting](https://github.com/daniel/blog-site) | Problems and solutions you might encounter during the realization of this lab| 



## NOTES: I will provide conmfig files for the networking configuration in folders so you can copy and paste.




## Virtual Box setup

This is the 2 boxes (or machines) selected for this lab. Notice that the Ram memory size for the Ubuntu Server is 2gb. I reccoment this amount for there are situations where 1 gb makes the system obviously slow or now even starting.

[![VB-GENERAL2.png](https://i.postimg.cc/4NY0ykDd/VB-GENERAL2.png)](https://postimg.cc/QHrmYPxG)



in the networking configuration tab we select internal network and assign a name. Isolated enviroment
[![VB-NET1.png](https://i.postimg.cc/RZKJMhGT/VB-NET1.png)](https://postimg.cc/sMfgmVkB)

---

## Networking files config and testing ping
let start with the Ubuntu server machine. you need to check for the network interface name you have, with the command "ip a" you can check it.




then Go to this path

```
/etc/netplan

```

then we will see a file with the "yaml" extension. that is the config file for the net related for the ubuntu. we going to change 2 things, add "address" line and specify the ip for this, since we dont have a DHCP to assing the ips we need to do this manually, that is, static . and change DHCP to "no". This file will be used to make an update of the system via iternet, so we need later to cahnge the network adapter to bridge mode to install those packages and install (if is not installed) openssh-server. we can check this if the sshd_config file is in the ssh path. for now just know taht this file is essential to switch between internet connection, host only connection or isolated. and all depends on commenting the static ip address line and changing the dhcp line to "yes"

```
network:
  version: 2
  ethernets:
    enp0s3:
      addresses: [10.10.10.11/24]
      dhcp4: no
```

Note: also you need to be very careful with the spaces of each line, it is very sensitive.

we apply changes with

```
sudo netplan apply

```

we will se with ip a, an ip assigned with 10.10.10.11 in the mask /24 tp change the 4th ip section 255

[![UBUNTU-IPA.png](https://i.postimg.cc/GtXjrQPV/UBUNTU-IPA.png)](https://postimg.cc/gL6hH3TH)


---

Now we go with Kali

same theory but here differs in the network. the path is

```
/etc/network/interfaces
```
this files is the one that manages the connection. one recommendation is to make sure to down the interface  with ipdown and then name of the interface. THis is more a good practice so there is no problems and we dont need to reboot the system. as the same with the netplan config we change for a static ip. THis fle is the one, if needed, to be changed depending if there is a network configuration on host only or bridge mode. we comment the lines of iface dhcp and add the static, address and net mask. Of course the address must be in the same domain of the other ubuntu
```
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback


#etho
auto eth0
#iface eth0 inet dhcp

iface eth0 inet static
       address 10.10.10.20     
       netmask 255.255.255.0
```

after this we can put up the interface 

```
sudo ifup eth0

#if any
sudo systemctl restart NetworkManager
```

check the ip


[![kali-ipa.png](https://i.postimg.cc/3NCKt30C/kali-ipa.png)](https://postimg.cc/gLjFJFDn)



now we check pings between the 2 machines.



Ubuntu

[![UBUNTU-PING.png](https://i.postimg.cc/VkWkNV0J/UBUNTU-PING.png)](https://postimg.cc/RWqBsGRm)


Kali

[![kali-ping.png](https://i.postimg.cc/nL0BPtBx/kali-ping.png)](https://postimg.cc/B8Pjjkm7)




now check they are really isolated, not even the host can reach them

[![host-ping.png](https://i.postimg.cc/J0fGbCP8/host-ping.png)](https://postimg.cc/H8tYgKqv)


from the ubuntu

[![UBUNTU-PING2.png](https://i.postimg.cc/SNXSWK2b/UBUNTU-PING2.png)](https://postimg.cc/JGLC8M5p)


from the kali

[![kali-ping2.png](https://i.postimg.cc/d1fdJm5S/kali-ping2.png)](https://postimg.cc/WFMtnrLM)





---




## SSH config

Now we need to modify the files for ssh connection. there are two files "ssh_config" and "sshd_config". the sshd is the (daemon) config file for the server side, that means for reciving the reqeust to be accesed remotly. so this file is olbigatory for the machine who is going to be accessed ssh. that does not means the sshd wont be need in the client machine, because there are situations to acces via ssh from server to client.

we going to start with Ubuntu

ssh_config file. Make sure the lines for Host is * which means any, in this case this situation is isolated, but in an enterprise situation we need to be acreful. and also that the port is 22 if there is any port 22 connection refused we need to have the same port for the machines, unless we do a port forwarding.

[![UBUNTU-SSHCONF.png](https://i.postimg.cc/RCwR9qrC/UBUNTU-SSHCONF.png)](https://postimg.cc/7bY7nHYj)

now for the sshd file 


[![UBUNTU-SSHD.png](https://i.postimg.cc/gkdK0ddV/UBUNTU-SSHD.png)](https://postimg.cc/HjZMSqrn)

restart the service

```
sudo systemctl restart ssh
```

*
*
*


now we can go with the kali before making any test connection. Again, ssh file and then sshd file.

ssh file first

[![KALI-SSH.png](https://i.postimg.cc/pV7JD8DB/KALI-SSH.png)](https://postimg.cc/V5qtwJZS)


next sshd

[![KALI-SSHD.png](https://i.postimg.cc/ht88W5NC/KALI-SSHD.png)](https://postimg.cc/nXz9q0F7)


restart the service

```
sudo systemctl restart ssh
```

*
*
*

check connection.

frist from ubuntu to kali

[![UBUNTU-SSH.png](https://i.postimg.cc/BQzhmkHR/UBUNTU-SSH.png)](https://postimg.cc/4mzbd881)


Kali to ubuntu


[![kali-sshconn.png](https://i.postimg.cc/L6jv2TWb/kali-sshconn.png)](https://postimg.cc/4mNp1zs6)

---


## ssh permissions configuration

this section is about how can we give permissions and restrictions based on ips or user. this kind of permissions can be made with firewalls, but because this lab is entirely focused with ssh, wanted to show that feature here as well.

first lets do this form the ubuntu server the restriction on the sshd file

[![UBUNTU-SSHD-RESTRICTION1.png](https://i.postimg.cc/Ls8JQ9fV/UBUNTU-SSHD-RESTRICTION1.png)](https://postimg.cc/DSRf8KxW)

we are saying? "hey ssh i need to restrict any connection that comes here calling for my name. if they come here calling for my buddy called "developer" let him inside".

Also for security measures the root ,and this comes by default, should not be accesed via ssh remote in enterprise enviroment.

*
*
*

checking if this works from the kali, first if root is accesible

[![SSH-ROOTDENIED.png](https://i.postimg.cc/fyVX2xtZ/SSH-ROOTDENIED.png)](https://postimg.cc/YLwhjLzy)


Done. now check if the user vboxuser can be accessed:

[![kali-sshdenied2.png](https://i.postimg.cc/d1HrjW04/kali-sshdenied2.png)](https://postimg.cc/r04D8Nxr)


Done. now cheack if the user we specify "devloper" is avaible to log in

[![kali-sshconn2.png](https://i.postimg.cc/ZK1PQDxQ/kali-sshconn2.png)](https://postimg.cc/rKNt0jbG)





---

## Troubleshooting

Kali port 22 connection refused?
if there is this type of problem we can fix it with the assignin of the port 22 in both files ssh and sshd (or the port you want to connect if avaible) then restart ssh service. to make sure the kali is listening in port 22 you can use this command:

```
sudo netstat -anp | grep ssh
```
we "filter" with grep for the ssh, if the port is not correclty assigned will show not port, like this:

[![NETSTAT-OUTPUT.png](https://i.postimg.cc/hv1kzBjX/NETSTAT-OUTPUT.png)](https://postimg.cc/QKV4wvcD)

if the port is correclty assigned will show this output instead:

[![NETSTAT-OUTPUT2.png](https://i.postimg.cc/FFb5njZh/NETSTAT-OUTPUT2.png)](https://postimg.cc/6TQm84gP)


also if we want to check if the service is running from the kali to ubuntu, we can use a little bit of scanning with nmap

[![kali-nmap.png](https://i.postimg.cc/x8Qr1C0r/kali-nmap.png)](https://postimg.cc/JDpYTRDK)

we can see the port 22 is open for ubuntu server with the service ssh













