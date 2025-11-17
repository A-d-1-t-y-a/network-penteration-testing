# Quick Reference Guide

## Essential Commands

### Nmap Scanning
```bash
# Basic scan
nmap -sS -sV -O <target>

# Full port scan
nmap -p- -sS -sV <target>

# UDP scan
nmap -sU <target>

# Aggressive scan with scripts
nmap -A <target>

# Save output
nmap -sS -sV -oN scan_results.txt <target>
nmap -sS -sV -oX scan_results.xml <target>
```

### Service Enumeration

#### HTTP/Web
```bash
# Directory brute-forcing
gobuster dir -u http://<target> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

# Nikto scan
nikto -h http://<target>

# Burp Suite (GUI tool)
# Use for manual web testing
```

#### SMB
```bash
# Enum4linux
enum4linux -a <target>

# SMB client
smbclient -L //<target>/
smbclient //<target>/share

# SMBMap
smbmap -H <target>
```

#### SSH
```bash
# Version check
nc <target> 22
ssh -v <target>

# Brute force (if needed)
hydra -l <user> -P <wordlist> ssh://<target>
```

### Metasploit
```bash
# Start Metasploit
msfconsole

# Search for exploit
search <keyword>

# Use exploit
use exploit/<path>

# Show options
show options

# Set target
set RHOSTS <target>
set LHOST <your_ip>

# Run exploit
exploit

# Post-exploitation
# After getting shell/meterpreter
sysinfo
getuid
hashdump
```

### Privilege Escalation

#### Linux
```bash
# LinPEAS
./linpeas.sh

# SUID finder
find / -perm -4000 2>/dev/null

# Sudo -l
sudo -l

# Kernel version
uname -a
```

#### Windows
```bash
# WinPEAS
.\winPEAS.exe

# System info
systeminfo

# Users
net user
net localgroup administrators

# Unquoted service paths
wmic service get name,pathname,displayname,startmode | findstr /i auto | findstr /i /v "C:\Windows\\" | findstr /i /v """
```

### Password Cracking
```bash
# John the Ripper
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt

# Hashcat
hashcat -m <hash_type> -a 0 hashes.txt /usr/share/wordlists/rockyou.txt

# Identify hash type
hash-identifier
```

## CVSS Quick Reference

### Base Score Metrics

**Attack Vector (AV)**:
- Network (N): 0.85
- Adjacent (A): 0.62
- Local (L): 0.55
- Physical (P): 0.20

**Attack Complexity (AC)**:
- Low (L): 0.77
- High (H): 0.44

**Privileges Required (PR)**:
- None (N): 0.85
- Low (L): 0.62
- High (H): 0.27

**User Interaction (UI)**:
- None (N): 0.85
- Required (R): 0.62

**Scope (S)**:
- Unchanged (U)
- Changed (C)

**Impact Metrics (C/I/A)**:
- None (N): 0.0
- Low (L): 0.22
- High (H): 0.56

**Severity Ratings**:
- 0.0: None
- 0.1-3.9: Low
- 4.0-6.9: Medium
- 7.0-8.9: High
- 9.0-10.0: Critical

**CVSS Calculator**: https://www.first.org/cvss/calculator/3.1

## PTES Phases

1. **Pre-engagement**
2. **Intelligence Gathering**
3. **Threat Modeling**
4. **Vulnerability Analysis**
5. **Exploitation**
6. **Post-Exploitation**
7. **Reporting**

## Common Ports and Services

| Port | Service | Common Tools |
|------|---------|--------------|
| 21 | FTP | ftp, hydra |
| 22 | SSH | ssh, hydra |
| 23 | Telnet | telnet, nc |
| 25 | SMTP | telnet, swaks |
| 53 | DNS | dig, nslookup |
| 80 | HTTP | curl, gobuster, burp |
| 135 | MSRPC | rpcclient |
| 139 | NetBIOS | enum4linux, smbclient |
| 443 | HTTPS | curl, gobuster, burp |
| 445 | SMB | smbclient, enum4linux |
| 3306 | MySQL | mysql, hydra |
| 3389 | RDP | rdesktop, xfreerdp |
| 5432 | PostgreSQL | psql, hydra |

## File Locations (Kali Linux)

### Wordlists
```
/usr/share/wordlists/
/usr/share/wordlists/rockyou.txt
/usr/share/wordlists/dirbuster/
/usr/share/wordlists/seclists/
```

### Exploits
```
/usr/share/exploitdb/
/opt/metasploit-framework/
```

### Tools
```
/usr/bin/          # Most tools
/opt/              # Optional tools
```

## Documentation Checklist

For each system, document:
- [ ] IP address
- [ ] Open ports
- [ ] Services and versions
- [ ] Vulnerabilities found
- [ ] Exploitation steps
- [ ] Commands executed
- [ ] Tool outputs
- [ ] Screenshots
- [ ] Flags obtained
- [ ] Time spent

## Report Sections (Quick)

1. Executive Summary
2. Selection of Networks/Systems
3. Methodology
4. Tools
5. Findings
6. Conclusions
7. Reflection and Individual Contribution
8. References
9. Appendices

## Key Requirements Reminder

- ✅ 4 systems
- ✅ 3+ systems from past 3 months
- ✅ Systems complement each other
- ✅ Complete network pentest
- ✅ ~25 page report
- ✅ IEEE citations
- ✅ Detailed appendices
- ✅ 10-15 slide presentation
- ✅ Forms completed

## Useful Websites

- **CVE Database**: https://cve.mitre.org/
- **Exploit-DB**: https://www.exploit-db.com/
- **CVSS Calculator**: https://www.first.org/cvss/calculator/3.1
- **Shodan**: https://www.shodan.io/
- **PTES**: http://www.pentest-standard.org/
- **OWASP**: https://owasp.org/

## Time Management Tips

- Week 1-2: Research and selection (20%)
- Week 3-5: Penetration testing (30%)
- Week 6-7: Report writing (40%)
- Week 8: Presentation and review (10%)

**Document as you go** - don't wait until the end!

## Emergency Contacts

- **Lecturers**: [Add contact info]
- **Platform Support**: Check platform forums
- **Technical Issues**: Document and continue, ask for help if needed

---

**Remember**: Document everything, take screenshots, save outputs, and cite your sources!

