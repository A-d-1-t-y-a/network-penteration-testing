#!/bin/bash
# SYSTEM 4: LOCK - FOCUSED COMMANDS (based on initial scan results)
# IP: 10.129.6.226
# Services: IIS (80), SMB (445), Gitea (3000), RDP (3389)

S4_IP="10.129.6.226"
OUTPUT_DIR="$HOME/Downloads/system4_lock_focused_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo "=========================================="
echo "SYSTEM 4: LOCK - FOCUSED ENUMERATION"
echo "=========================================="
echo "Known services:"
echo "  - Port 80: IIS 10.0"
echo "  - Port 445: SMB"
echo "  - Port 3000: Gitea (Git service)"
echo "  - Port 3389: RDP"
echo ""

# ============================================
# GITEA ENUMERATION (Port 3000) - PRIORITY!
# ============================================
echo "[*] PRIORITY: Gitea enumeration (port 3000)"

# Gitea home page
curl -s http://$S4_IP:3000/ > gitea_home.html
echo "[+] Saved: gitea_home.html"

# Gitea version/API
curl -s http://$S4_IP:3000/api/v1/version > gitea_version.json
echo "[+] Saved: gitea_version.json"

# Gitea explore (public repos)
curl -s http://$S4_IP:3000/explore/repos > gitea_repos.html
echo "[+] Saved: gitea_repos.html"

# Gitea users
curl -s http://$S4_IP:3000/api/v1/users/search > gitea_users.json
echo "[+] Saved: gitea_users.json"

# Gitea common paths
for path in login register api/v1/repos explore/users explore/repos user/sign_up user/login; do
    echo "[+] Checking: http://$S4_IP:3000/$path"
    curl -s http://$S4_IP:3000/$path > "gitea_${path//\//_}.html" 2>&1
done

# Directory enumeration on Gitea
echo "[+] Running directory enumeration on Gitea..."
ffuf -u http://$S4_IP:3000/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 30 -o gitea_ffuf.json -s 2>/dev/null

# ============================================
# IIS WEB ENUMERATION (Port 80)
# ============================================
echo "[*] IIS web enumeration (port 80)"

# IIS home page
curl -s http://$S4_IP/ > iis_home.html
echo "[+] Saved: iis_home.html"

# Common IIS paths
for path in aspnet_client iisstart.htm welcome.png web.config; do
    curl -s http://$S4_IP/$path > "iis_${path//\//_}.txt" 2>&1
done

# Directory enumeration on IIS
echo "[+] Running directory enumeration on IIS..."
ffuf -u http://$S4_IP/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/IIS.fuzz.txt -mc 200,204,301,302,307,401,403 -t 30 -o iis_ffuf.json -s 2>/dev/null

# ============================================
# SMB ENUMERATION (Port 445)
# ============================================
echo "[*] SMB enumeration (port 445)"

# SMB shares (anonymous)
smbclient -L //$S4_IP/ -N > smb_shares.txt 2>&1
echo "[+] Saved: smb_shares.txt"

# SMB null session
smbclient //$S4_IP/IPC$ -N > smb_null.txt 2>&1
echo "[+] Saved: smb_null.txt"

# Crackmapexec (if installed)
if command -v crackmapexec &> /dev/null; then
    crackmapexec smb $S4_IP > smb_cme.txt 2>&1
    echo "[+] Saved: smb_cme.txt"
fi

# ============================================
# RDP ENUMERATION (Port 3389)
# ============================================
echo "[*] RDP enumeration (port 3389)"

# RDP detailed info
nmap -p 3389 --script rdp-enum-encryption,rdp-ntlm-info -oN rdp_info.txt $S4_IP
echo "[+] Saved: rdp_info.txt"

# ============================================
# VULNERABILITY SEARCH
# ============================================
echo "[*] Searching for exploits"

# Gitea exploits
searchsploit gitea > exploits_gitea.txt 2>&1
echo "[+] Saved: exploits_gitea.txt"

# IIS exploits
searchsploit "iis 10" > exploits_iis.txt 2>&1
echo "[+] Saved: exploits_iis.txt"

# ============================================
# SUMMARY
# ============================================
echo ""
echo "=========================================="
echo "FOCUSED ENUMERATION COMPLETE"
echo "=========================================="
echo "Results saved to: $OUTPUT_DIR"
echo ""
echo "Key files to review:"
echo "  - gitea_home.html (Gitea homepage)"
echo "  - gitea_version.json (Gitea version)"
echo "  - gitea_repos.html (Public repositories)"
echo "  - gitea_users.json (User list)"
echo "  - iis_home.html (IIS homepage)"
echo "  - smb_shares.txt (SMB shares)"
echo "  - rdp_info.txt (RDP info)"
echo "  - exploits_gitea.txt (Gitea exploits)"
echo ""
ls -lh "$OUTPUT_DIR"

