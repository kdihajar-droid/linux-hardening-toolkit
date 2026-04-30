# Linux-Hardening-Toolkit 

Automated Bash scripts to secure Linux servers based on CIS Benchmarks Level 1. This toolkit is part of my journey into Cybersecurity automation.

##  What it does
This script `harden-centos.sh` automatically implements critical security controls:
- ✅ **System Updates**: Patches all packages to fix known vulnerabilities
- ✅ **Brute-Force Protection**: Installs & configures Fail2ban for SSH
- ✅ **SSH Hardening**: Disables direct root login, a major CIS requirement
- ✅ **Firewall Policy**: Configures Firewalld with "Default Deny" - only SSH, HTTP, HTTPS allowed

##  How to Use
```bash
# 1. Clone the repository
git clone https://github.com/kdihajar-droid/Linux-Hardening-Toolkit.git

# 2. Navigate to the directory
cd Linux-Hardening-Toolkit

# 3. Make the script executable
chmod +x harden-centos.sh

# 4. Run with root privileges
sudo ./harden-centos.sh

## Features

- ✅ **Defensive Scripting**: Pre-flight root check and fail-fast error handling with `set -euo pipefail`
- ✅ **Configuration Safety**: Automated `.bak` backups before modifying system files
- ✅ **Idempotent**: Safe to run multiple times without unintended side effects
- ✅ **CIS Level 1**: Implements critical security controls from CIS Benchmark

## Troubleshooting CentOS 8 EOL

CentOS 8 reached End-of-Life. If `yum update` fails, switch repos to `vault.centos.org`:
```bash
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

## Contributors

This project exists thanks to all the people who contribute.

- **Hajar Kandri** - *Project Creator & Maintainer* - Initial CIS Level 1 implementation and project architecture
- **@ou-bash** - *Contributor* - Major refactor: defensive scripting, idempotency, and automated configuration backups
