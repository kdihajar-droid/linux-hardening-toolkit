#!/bin/bash
# CentOS 8 Hardening Script - By Hajar Kandri
# Based on CIS Benchmark Level 1

echo "[+] Starting CentOS Hardening..."

# 1. Update the system
echo "[+] Updating system packages..."
yum update -y

# 2. Install Fail2ban to prevent brute force
echo "[+] Installing Fail2ban..."
yum install epel-release -y
yum install fail2ban -y
systemctl enable fail2ban
systemctl start fail2ban

# 3. Disable Root SSH Login
echo "[+] Disabling SSH Root Login..."
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
systemctl restart sshd

# 4. Enable Firewalld and allow only SSH, HTTP, HTTPS
echo "[+] Configuring Firewall..."
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --set-default-zone=drop
firewall-cmd --permanent --add-service=ssh
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

echo "[+] Basic Hardening Complete! Server is now more secure."
