# Penetration Testing Methodology Guide

## PTES (Penetration Testing Execution Standard) Framework

### 1. Pre-engagement Interactions

**Purpose**: Establish scope, rules, and expectations before testing begins.

**Activities**:
- Define scope of testing
- Establish rules of engagement
- Set communication channels
- Agree on testing windows
- Define success criteria
- Discuss reporting requirements

**Documentation**:
- Scope document
- Rules of engagement
- Communication plan

### 2. Intelligence Gathering

**Purpose**: Collect information about the target without direct interaction.

#### 2.1 Passive Reconnaissance

**OSINT (Open Source Intelligence)**:
- Google Dorking
- Social media research
- Company website analysis
- Job postings (reveal technologies)
- DNS records
- WHOIS information
- Certificate transparency logs

**Tools**:
- theHarvester
- Shodan
- Google
- Maltego
- Recon-ng
- DNSenum

**What to Document**:
- Domain names
- Subdomains
- IP addresses
- Technologies identified
- Employee information
- Email addresses

#### 2.2 Active Reconnaissance

**DNS Enumeration**:
- Zone transfers
- DNS records (A, MX, TXT, etc.)
- Subdomain enumeration

**Tools**: DNSenum, DNSrecon, Sublist3r

### 3. Threat Modeling

**Purpose**: Identify potential threats and attack vectors.

**Considerations**:
- Threat actors (external hackers, insiders, etc.)
- Attack vectors
- Business impact
- Asset value
- Likelihood of attack

**Documentation**: Threat model diagram or table

### 4. Vulnerability Analysis

**Purpose**: Identify vulnerabilities in target systems.

#### 4.1 Network Scanning

**Port Scanning**:
- TCP SYN scan
- UDP scan
- Service version detection
- OS detection

**Nmap Commands**:
```bash
# Basic scan
nmap -sS -sV -O <target>

# Full port scan
nmap -p- -sS -sV <target>

# UDP scan
nmap -sU <target>

# Aggressive scan with scripts
nmap -A <target>
```

**Documentation**: Save all scan results

#### 4.2 Service Enumeration

**For Each Open Port**:
- Identify service version
- Check default credentials
- Enumerate service-specific information
- Check for known vulnerabilities

**Common Services**:
- **HTTP/HTTPS**: Web server enumeration, directory brute-forcing
- **SSH**: Version, key exchange algorithms
- **FTP**: Anonymous access, version
- **SMB**: Shares, users, versions
- **RDP**: Version, security settings
- **MySQL/PostgreSQL**: Version, default credentials
- **Redis**: Unauthenticated access

**Tools**:
- Gobuster/Dirbuster (web directories)
- Enum4linux (SMB)
- RPCclient (RPC)
- SNMPwalk (SNMP)

#### 4.3 Vulnerability Scanning

**Automated Scanners**:
- OpenVAS
- Nessus
- Nikto (web applications)
- WPScan (WordPress)

**Manual Analysis**:
- Review service versions against CVE databases
- Check exploit databases (Exploit-DB, Metasploit)
- Analyze application responses
- Test for common misconfigurations

**Documentation**:
- Vulnerability scan reports
- CVE numbers
- CVSS scores
- Proof of concept

### 5. Exploitation

**Purpose**: Gain unauthorized access to systems.

#### 5.1 Exploit Selection

**Sources**:
- Metasploit Framework
- Exploit-DB
- GitHub (public exploits)
- Custom exploits

**Considerations**:
- Exploit reliability
- Detection risk
- Impact on target
- Required privileges

#### 5.2 Exploitation Process

**Steps**:
1. Prepare exploit environment
2. Set exploit parameters
3. Execute exploit
4. Verify access
5. Document proof (screenshots, flags)

**Common Exploitation Techniques**:
- Buffer overflows
- SQL injection
- Command injection
- File upload vulnerabilities
- Authentication bypass
- Privilege escalation exploits
- Misconfigurations

**Tools**:
- Metasploit Framework
- SQLMap
- Custom scripts
- Manual exploitation

**Documentation**:
- Exploit used
- Commands executed
- Screenshots of successful exploitation
- Proof of access (flags, user.txt, root.txt)

### 6. Post-Exploitation

**Purpose**: Maintain access, escalate privileges, and gather information.

#### 6.1 Initial Access Stabilization

**Activities**:
- Upgrade shell (if needed)
- Establish persistence
- Remove evidence
- Set up backdoors

**Tools**:
- Meterpreter
- Netcat
- SSH keys
- Scheduled tasks/cron jobs

#### 6.2 Privilege Escalation

**Linux**:
- SUID binaries
- Sudo misconfigurations
- Kernel exploits
- Cron job vulnerabilities
- PATH hijacking

**Windows**:
- Unquoted service paths
- AlwaysInstallElevated
- Token impersonation
- DLL hijacking
- Kernel exploits

**Tools**:
- LinPEAS (Linux)
- WinPEAS (Windows)
- PowerUp (Windows)
- BloodHound (Active Directory)

#### 6.3 Information Gathering

**System Information**:
- OS version
- Installed software
- Network configuration
- User accounts
- Running processes
- Scheduled tasks

**Credentials**:
- Password hashes (SAM, /etc/shadow)
- Clear-text passwords
- SSH keys
- Database credentials
- Application secrets

**Tools**:
- Mimikatz (Windows)
- Hashcat/John the Ripper
- Secretsdump
- LaZagne

#### 6.4 Lateral Movement

**Activities**:
- Pivot to other systems
- Pass-the-hash
- Token reuse
- SSH key reuse
- SMB shares

**Tools**:
- Proxychains
- SSH tunnels
- Metasploit pivoting
- BloodHound

#### 6.5 Data Exfiltration

**Activities**:
- Identify sensitive data
- Compress data
- Transfer data
- Verify transfer

**Documentation**:
- What data was accessed
- Data sensitivity
- Transfer method
- Proof of exfiltration

### 7. Reporting

**Purpose**: Document findings and provide recommendations.

**See Report Structure in PROJECT_PLAN.md**

## Risk Rating Methodology

### CVSS (Common Vulnerability Scoring System) v3.1

**Base Score Metrics**:

1. **Attack Vector (AV)**:
   - Network (N): 0.85
   - Adjacent (A): 0.62
   - Local (L): 0.55
   - Physical (P): 0.20

2. **Attack Complexity (AC)**:
   - Low (L): 0.77
   - High (H): 0.44

3. **Privileges Required (PR)**:
   - None (N): 0.85
   - Low (L): 0.62 (User)
   - High (H): 0.27 (Admin)

4. **User Interaction (UI)**:
   - None (N): 0.85
   - Required (R): 0.62

5. **Scope (S)**:
   - Unchanged (U): Scope unchanged
   - Changed (C): Scope changed

6. **Confidentiality (C)**:
   - None (N): 0.0
   - Low (L): 0.22
   - High (H): 0.56

7. **Integrity (I)**:
   - None (N): 0.0
   - Low (L): 0.22
   - High (H): 0.56

8. **Availability (A)**:
   - None (N): 0.0
   - Low (L): 0.22
   - High (H): 0.56

**Severity Ratings**:
- **0.0**: None
- **0.1-3.9**: Low
- **4.0-6.9**: Medium
- **7.0-8.9**: High
- **9.0-10.0**: Critical

**CVSS Calculator**: https://www.first.org/cvss/calculator/3.1

### Alternative: NIST Risk Rating

**Formula**: Risk = Threat × Vulnerability × Impact

**Values**: Low (1), Medium (2), High (3), Critical (4)

**Risk Matrix**: See PROJECT_PLAN.md for table

## Documentation Requirements

### For Each Phase, Document:

1. **Commands Executed**: All commands with outputs
2. **Screenshots**: Key steps and results
3. **Tool Outputs**: Save raw outputs
4. **Timestamps**: When each activity occurred
5. **IP Addresses**: All IPs discovered
6. **Ports**: All open ports and services
7. **Credentials**: Any discovered (document securely)
8. **Vulnerabilities**: All identified with details
9. **Exploits**: Which exploits were used
10. **Proof**: Flags, user.txt, root.txt, screenshots

### File Naming Convention

```
system1_reconnaissance_20241101.txt
system1_nmap_scan_20241101.xml
system1_exploitation_screenshot1.png
system1_postexploit_hashdump.txt
```

## Best Practices

1. **Document as You Go**: Don't wait until the end
2. **Take Many Screenshots**: Better to have too many than too few
3. **Save All Outputs**: Tool outputs are valuable
4. **Version Control**: Use Git for documentation
5. **Backup**: Regular backups of all work
6. **Time Tracking**: Note time spent on each phase
7. **Peer Review**: Review each other's work
8. **Ethical Considerations**: Always follow rules of engagement

## Common Tools by Phase

### Intelligence Gathering
- theHarvester
- Shodan
- Maltego
- DNSenum
- Sublist3r

### Scanning
- Nmap
- Masscan
- RustScan
- OpenVAS
- Nessus

### Web Application Testing
- Burp Suite
- OWASP ZAP
- Nikto
- SQLMap
- Gobuster

### Exploitation
- Metasploit Framework
- Exploit-DB
- Custom scripts
- Manual exploitation

### Post-Exploitation
- Meterpreter
- LinPEAS/WinPEAS
- Mimikatz
- BloodHound
- Hashcat
- John the Ripper

## References

- PTES: http://www.pentest-standard.org/
- CVSS v3.1: https://www.first.org/cvss/
- NIST SP 800-30: Risk Management Guide
- OWASP Testing Guide: https://owasp.org/www-project-web-security-testing-guide/

