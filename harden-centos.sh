#!/bin/bash
# CentOS 8 Hardening Script 
# Based on CIS Benchmark Level 1

export LC_ALL=C

# --- 1. PRE-FLIGHT CHECKS ---
if [[ $EUID -ne 0 ]]; then
   echo "[!] Error: This script must be run as root. Use: sudo $0"
   exit 1
fi

# Check for essential tools
for cmd in yum systemctl grep sed; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "[!] Error: Required tool '$cmd' is missing."
        exit 1
    fi
done

echo "[+] Starting CentOS Hardening..."

# --- 2. HELPER FUNCTIONS ---
backup_file() {
    local FILE=$1
    if [ -f "$FILE" ] && [ ! -f "${FILE}.bak" ]; then
        cp "$FILE" "${FILE}.bak"
        echo "[*] Created backup: ${FILE}.bak"
    fi
}

# --- 3. SYSTEM UPDATES ---
echo "[+] Updating system packages..."
yum update -y || { echo "[!] Update failed. Check mirrors."; exit 1; }

# --- 4. BRUTE-FORCE PROTECTION ---
echo "[+] Installing Fail2ban..."
yum install epel-release -y && yum install fail2ban -y
if systemctl list-unit-files | grep -q "fail2ban.service"; then
    systemctl enable --now fail2ban
else
    echo "[!] Warning: Fail2ban service not found after installation."
fi

# --- 5. SSH HARDENING ---
SSH_CONF="/etc/ssh/sshd_config"
if [ -f "$SSH_CONF" ]; then
    echo "[+] Securing SSH configuration..."
    backup_file "$SSH_CONF"
    sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' "$SSH_CONF"
    systemctl restart sshd
else
    echo "[!] Warning: SSH config not found at $SSH_CONF. Skipping."
fi

# --- 6. FIREWALL CONFIGURATION ---
if command -v firewall-cmd &> /dev/null; then
    echo "[+] Configuring Firewalld..."
    systemctl enable --now firewalld
    firewall-cmd --set-default-zone=drop
    for svc in ssh http https; do
        firewall-cmd --permanent --add-service=$svc
    done
    firewall-cmd --reload
else
    echo "[!] Warning: firewall-cmd not found. Skipping firewall rules."
fi

echo "--------------------------------------------------"
echo "[+] Hardening Process Finished!"
