#!/bin/bash
# System 4 Initial Reconnaissance Commands
# Replace <SYSTEM4_IP> with actual IP address

echo "=== System 4: Initial Reconnaissance ==="
echo ""
echo "RECOMMENDATION: Stay with HackTheBox for System 4"
echo "- Already set up (VPN, account, machines)"
echo "- Consistent documentation"
echo "- Choose an EASIER/OLDER machine (2023 or earlier is OK for 4th system)"
echo "- Look for: Easy/Medium difficulty, high ratings, active users"
echo ""
echo "Please provide:"
echo "1. System name"
echo "2. IP address"
echo "3. Platform (HTB/TryHackMe/etc.)"
echo "4. Release date"
echo ""
echo "Then run these commands:"

# Replace <SYSTEM4_IP> with actual IP
SYSTEM4_IP="<SYSTEM4_IP>"
SYSTEM4_NAME="<SYSTEM4_NAME>"

echo ""
echo "=== Step 1: Basic connectivity ==="
echo "ping -c 4 $SYSTEM4_IP"

echo ""
echo "=== Step 2: Initial Nmap scan ==="
echo "nmap -sC -sV -oN s4_initial.txt $SYSTEM4_IP"

echo ""
echo "=== Step 3: Full port scan ==="
echo "nmap -p- --min-rate 2000 -oN s4_full.txt $SYSTEM4_IP"

echo ""
echo "=== Step 4: Service-specific enumeration (run based on open ports) ==="
echo ""
echo "# If HTTP (80/443/8080):"
echo "ffuf -u http://\$SYSTEM4_IP/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50"
echo "curl -s http://\$SYSTEM4_IP/ | head -60"
echo ""
echo "# If SMB (445):"
echo "enum4linux -a \$SYSTEM4_IP"
echo "smbclient -L //\$SYSTEM4_IP/ -N"
echo ""
echo "# If FTP (21):"
echo "ftp \$SYSTEM4_IP  # try anonymous"
echo ""
echo "# If RDP (3389):"
echo "xfreerdp /v:\$SYSTEM4_IP /u: /p: /cert:ignore"
echo ""
echo "# If SSH (22):"
echo "ssh -o PreferredAuthentications=none \$SYSTEM4_IP"

