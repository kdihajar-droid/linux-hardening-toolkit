# Linux-Hardening-Toolkit 🛡️

Automated Bash scripts to secure Linux servers based on CIS Benchmarks Level 1. This toolkit is part of my journey into Cybersecurity automation.

## 🚀 What it does
This script `harden-centos.sh` automatically implements critical security controls:
- ✅ **System Updates**: Patches all packages to fix known vulnerabilities
- ✅ **Brute-Force Protection**: Installs & configures Fail2ban for SSH
- ✅ **SSH Hardening**: Disables direct root login, a major CIS requirement
- ✅ **Firewall Policy**: Configures Firewalld with "Default Deny" - only SSH, HTTP, HTTPS allowed

## ⚙️ How to Use
```bash
# 1. Clone the repository
git clone https://github.com/kdihajar-droid/Linux-Hardening-Toolkit.git

# 2. Navigate to the directory
cd Linux-Hardening-Toolkit

# 3. Make the script executable
chmod +x harden-centos.sh

# 4. Run with root privileges
sudo ./harden-centos.sh
