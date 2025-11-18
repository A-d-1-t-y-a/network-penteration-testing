#!/bin/bash
# MASTER RECONNAISSANCE SCRIPT - ALL SYSTEMS IN PARALLEL
# Usage: Update IPs below, then run: bash master_recon_all_systems.sh

# ============================================
# UPDATE THESE IPs FOR YOUR SYSTEMS
# ============================================
S1_IP="10.10.11.80"    # System 1: Editor
S1_NAME="editor.htb"
S2_IP="10.10.11.90"    # System 2: Signed
S2_NAME="signed.htb"
S3_IP="10.10.11.86"    # System 3: Soulmate
S3_NAME="soulmate.htb"
S4_IP="10.129.6.226"    # System 4: Lock
S4_NAME="lock.htb"

# ============================================
# OUTPUT DIRECTORY
# ============================================
OUTPUT_DIR="$HOME/Downloads/htb_recon_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"/{system1,system2,system3,system4}

echo "=========================================="
echo "MASTER RECONNAISSANCE - ALL SYSTEMS"
echo "=========================================="
echo "Output Directory: $OUTPUT_DIR"
echo "Starting at: $(date)"
echo ""

# ============================================
# SYSTEM 1: EDITOR (Linux - Web + XWiki)
# ============================================
echo "[*] Starting System 1: Editor ($S1_IP)"
(
    cd "$OUTPUT_DIR/system1"
    
    # Basic connectivity
    ping -c 4 $S1_IP > ping.txt 2>&1
    
    # Initial scan
    nmap -sC -sV -oN s1_initial.txt $S1_IP
    
    # Full port scan (background)
    nmap -p- --min-rate 2000 -oN s1_full.txt $S1_IP &
    
    # Web enumeration
    curl -s -L http://$S1_IP/ > web_root.html
    curl -s http://$S1_IP:8080/xwiki/rest/ > xwiki_rest.txt
    ffuf -u http://$S1_IP/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o s1_ffuf_common.json -s 2>/dev/null
    
    # XWiki specific
    curl -s http://$S1_IP:8080/xwiki/bin/view/Main/WebHome | head -100 > xwiki_home.txt
    curl -s http://$S1_IP:8080/xwiki/bin/login/XWiki/XWikiLogin | head -100 > xwiki_login.txt
    
    # SSH banner
    nc $S1_IP 22 < /dev/null > ssh_banner.txt 2>&1
    
    echo "[+] System 1: Editor - Initial recon complete"
) &

# ============================================
# SYSTEM 2: SIGNED (Windows - MSSQL)
# ============================================
echo "[*] Starting System 2: Signed ($S2_IP)"
(
    cd "$OUTPUT_DIR/system2"
    
    # Basic connectivity
    ping -c 4 $S2_IP > ping.txt 2>&1
    
    # Initial scan
    nmap -sC -sV -oN s2_initial.txt $S2_IP
    
    # Full port scan (background)
    nmap -p- --min-rate 2000 -oN s2_full.txt $S2_IP &
    
    # MSSQL detailed scan
    nmap -p 1433 --script ms-sql-info,ms-sql-ntlm-info,ms-sql-empty-password,ms-sql-brute --script-args userdb=users.txt,passdb=passwords.txt,ms-sql-brute.timeout=5 -oN s2_mssql_detailed.txt $S2_IP &
    
    # SMB enumeration (if ports open)
    enum4linux -a $S2_IP > s2_enum4linux.txt 2>&1 &
    smbclient -L //$S2_IP/ -N > s2_smbclient.txt 2>&1 &
    
    # Web (if port 80/443 opens)
    curl -s http://$S2_IP/ > web_root.html 2>&1
    ffuf -u http://$S2_IP/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o s2_ffuf_common.json -s 2>/dev/null &
    
    echo "[+] System 2: Signed - Initial recon complete"
) &

# ============================================
# SYSTEM 3: SOULMATE (Linux - Web + Erlang)
# ============================================
echo "[*] Starting System 3: Soulmate ($S3_IP)"
(
    cd "$OUTPUT_DIR/system3"
    
    # Basic connectivity
    ping -c 4 $S3_IP > ping.txt 2>&1
    
    # Initial scan
    nmap -sC -sV -oN s3_initial.txt $S3_IP
    
    # Full port scan (background)
    nmap -p- --min-rate 2000 -oN s3_full.txt $S3_IP &
    
    # Web enumeration
    curl -s -L http://$S3_NAME/ > web_root.html 2>&1
    curl -s http://$S3_NAME/robots.txt > robots.txt 2>&1
    ffuf -u http://$S3_NAME/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o s3_ffuf_common.json -s 2>/dev/null &
    
    # Try larger wordlist in background
    ffuf -u http://$S3_NAME/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -mc 200,204,301,302,307,401,403 -t 50 -o s3_ffuf_medium.json -s 2>/dev/null &
    
    # Erlang/epmd investigation
    echo "names" | nc $S3_IP 4369 > epmd_query.txt 2>&1
    
    # SSH banner
    nc $S3_IP 22 < /dev/null > ssh_banner.txt 2>&1
    
    echo "[+] System 3: Soulmate - Initial recon complete"
) &

# ============================================
# SYSTEM 4: <UPDATE_NAME> (<UPDATE_OS>)
# ============================================
echo "[*] Starting System 4: <UPDATE_NAME> ($S4_IP)"
(
    cd "$OUTPUT_DIR/system4"
    
    # Basic connectivity
    ping -c 4 $S4_IP > ping.txt 2>&1
    
    # Initial scan
    nmap -sC -sV -oN s4_initial.txt $S4_IP
    
    # Full port scan (background)
    nmap -p- --min-rate 2000 -oN s4_full.txt $S4_IP &
    
    # Web enumeration (if port 80/443)
    curl -s -L http://$S4_IP/ > web_root.html 2>&1
    curl -s http://$S4_IP/robots.txt > robots.txt 2>&1
    ffuf -u http://$S4_IP/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o s4_ffuf_common.json -s 2>/dev/null &
    
    # Service-specific (update based on open ports)
    # SMB
    enum4linux -a $S4_IP > s4_enum4linux.txt 2>&1 &
    smbclient -L //$S4_IP/ -N > s4_smbclient.txt 2>&1 &
    
    # FTP
    ftp -n $S4_IP <<EOF > s4_ftp.txt 2>&1
user anonymous anonymous
quit
EOF
    
    # SSH
    nc $S4_IP 22 < /dev/null > ssh_banner.txt 2>&1
    
    echo "[+] System 4: <UPDATE_NAME> - Initial recon complete"
) &

# ============================================
# WAIT FOR ALL BACKGROUND JOBS
# ============================================
echo ""
echo "[*] All systems started in parallel..."
echo "[*] Waiting for initial scans to complete..."
wait

echo ""
echo "=========================================="
echo "INITIAL RECONNAISSANCE COMPLETE"
echo "=========================================="
echo "Results saved to: $OUTPUT_DIR"
echo "Completed at: $(date)"
echo ""
echo "Next: Review results and run exploitation scripts"

