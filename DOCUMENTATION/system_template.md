# System [N] Penetration Test Documentation

## System Information

- **System Name**: [Name]
- **Platform**: [HackTheBox/TryHackMe/VulnHub/etc.]
- **Release Date**: [Date]
- **Difficulty Rating**: [Easy/Medium/Hard/Insane]
- **Operating System**: [OS and version]
- **IP Address**: [IP]
- **Target Machine**: [Machine name if applicable]

---

## Network Diagram

[Insert network diagram showing attacking machine and target]

---

## Timeline

| Phase | Start Date/Time | End Date/Time | Duration |
|-------|----------------|---------------|----------|
| Intelligence Gathering | | | |
| Vulnerability Analysis | | | |
| Exploitation | | | |
| Post-Exploitation | | | |
| Documentation | | | |

---

## 1. Intelligence Gathering

### 1.1 Passive Reconnaissance

**Activities**:
- [List activities performed]

**Tools Used**:
- [Tool 1]
- [Tool 2]

**Findings**:
- [Key findings]

**Screenshots**:
- [Screenshot 1: Description]
- [Screenshot 2: Description]

**Commands and Outputs**:
```bash
[Command]
[Output]
```

### 1.2 Active Reconnaissance

**DNS Enumeration**:
```bash
[Commands and outputs]
```

**Subdomain Discovery**:
```bash
[Commands and outputs]
```

---

## 2. Vulnerability Analysis

### 2.1 Port Scanning

**Initial Scan**:
```bash
nmap -sS -sV -O <target_ip>
```

**Output**:
```
[Paste nmap output]
```

**Open Ports Summary**:
| Port | Protocol | Service | Version |
|------|----------|---------|---------|
| 22 | TCP | SSH | OpenSSH 7.4 |
| 80 | TCP | HTTP | Apache 2.4.6 |
| [Add more] | | | |

**Screenshot**: [Screenshot of scan results]

### 2.2 Service Enumeration

#### HTTP Service (Port 80)

**Web Server Information**:
- Server: [Server type and version]
- Technologies: [PHP, Python, etc.]

**Directory Enumeration**:
```bash
gobuster dir -u http://<target_ip> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
```

**Findings**:
- [List discovered directories/files]

**Screenshot**: [Screenshot of web interface]

#### [Other Services]

[Repeat for each service]

### 2.3 Vulnerability Scanning

**Automated Scan**:
- Tool: [OpenVAS/Nessus/etc.]
- Scan Date: [Date]
- Findings: [Summary]

**Manual Analysis**:
- Service versions checked against CVE databases
- Exploit-DB searches
- Manual testing for common vulnerabilities

**Identified Vulnerabilities**:
1. **[Vulnerability 1]**
   - CVE: [CVE number if applicable]
   - CVSS Score: [Score]
   - Description: [Description]

2. **[Vulnerability 2]**
   - [Details]

---

## 3. Exploitation

### 3.1 Initial Access

**Vulnerability Exploited**: [Vulnerability name]
**CVE/Reference**: [CVE or reference]
**Exploit Used**: [Exploit name/source]

**Exploitation Steps**:

1. **Preparation**:
```bash
[Commands]
```

2. **Exploit Execution**:
```bash
[Commands]
[Output]
```

3. **Verification**:
```bash
[Commands to verify access]
[Output showing successful access]
```

**Screenshots**:
- [Screenshot 1: Exploit execution]
- [Screenshot 2: Proof of access]

**Proof of Access**:
- User flag location: [Path]
- User flag: [Flag value - if allowed to document]
- Screenshot: [Screenshot of flag]

### 3.2 [Additional Exploitation]

[If multiple exploitation paths were used, document each]

---

## 4. Post-Exploitation

### 4.1 System Information

**OS Details**:
```bash
[Commands to gather OS info]
[Output]
```

**User Information**:
```bash
[Commands]
[Output]
```

**Network Configuration**:
```bash
[Commands]
[Output]
```

### 4.2 Privilege Escalation

**Method Used**: [Method name]
**Vulnerability**: [Vulnerability exploited]

**Steps**:
1. [Step 1]
```bash
[Commands]
[Output]
```

2. [Step 2]
```bash
[Commands]
[Output]
```

**Screenshots**:
- [Screenshot of privilege escalation]
- [Screenshot showing root/admin access]

**Proof of Root/Admin Access**:
- Root flag location: [Path]
- Root flag: [Flag value - if allowed]
- Screenshot: [Screenshot]

### 4.3 Credential Extraction

**Hashes Extracted**:
```bash
[Commands to extract hashes]
[Output]
```

**Cracking Attempts**:
```bash
[Commands if hashes were cracked]
[Results]
```

### 4.4 Lateral Movement

[If applicable, document lateral movement to other systems]

### 4.5 Persistence

[If persistence mechanisms were established, document them]

### 4.6 Data Exfiltration

[If data was exfiltrated, document what and how]

---

## 5. Findings Summary

### Vulnerabilities Identified

| ID | Vulnerability | Severity | CVSS | Exploited |
|----|--------------|----------|------|-----------|
| VULN-001 | [Name] | Critical | 9.8 | Yes |
| VULN-002 | [Name] | High | 7.5 | Yes |
| [Add more] | | | | |

### Key Findings

1. **[Finding 1]**
   - Description: [Description]
   - Impact: [Impact]
   - Recommendation: [Recommendation]

2. **[Finding 2]**
   - [Details]

---

## 6. Lessons Learned

**What Worked Well**:
- [List successful techniques/approaches]

**Challenges Faced**:
- [List challenges and how they were overcome]

**New Techniques Learned**:
- [List new skills/knowledge gained]

**Time Spent**:
- Total time: [Hours]
- Breakdown by phase: [Breakdown]

---

## 7. References

[List references used for this system, including walkthroughs if consulted]

1. [Reference 1]
2. [Reference 2]
3. [Reference 3]

---

## Appendix: Complete Command History

[Optional: Complete log of all commands executed]

```bash
[Chronological list of all commands]
```

---

## Appendix: Screenshots Index

1. [Screenshot filename]: [Description]
2. [Screenshot filename]: [Description]
3. [Continue...]

