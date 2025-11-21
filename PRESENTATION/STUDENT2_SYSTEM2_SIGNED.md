# Student 2: System 2 (Signed) - Presentation Guide
## Complete Presentation Content for Team Member 2

---

## 1. TASK/AIM FOR THIS STUDENT

### Primary Objective
**Conduct comprehensive penetration testing on System 2 (Signed) - a Windows Server 2019 Domain Controller running Microsoft SQL Server 2022, following PTES methodology to identify vulnerabilities, attempt exploitation, and document findings professionally.**

### Specific Goals
- **Reconnaissance**: Identify all open ports, services, and versions on the Windows Domain Controller
- **MSSQL Analysis**: Enumerate Microsoft SQL Server configuration, authentication methods, and potential vulnerabilities
- **Domain Enumeration**: Gather Active Directory information through MSSQL NTLM authentication
- **Exploitation**: Attempt to gain database access through credential brute-forcing and authentication bypass
- **Documentation**: Create comprehensive documentation of all findings, methodologies, and evidence
- **Risk Assessment**: Calculate CVSS scores and provide remediation recommendations

### System Details
- **Target Name**: Signed
- **IP Address**: 10.10.11.90
- **Operating System**: Windows Server 2019 (Build 10.0.17763)
- **Domain**: SIGNED.HTB
- **Computer Name**: DC01 (Domain Controller)
- **Platform**: HackTheBox
- **Release Date**: 11 Oct 2025
- **Primary Service**: Microsoft SQL Server 2022 RC0+ (Port 1433)

---

## 2. WHAT THEY NEED TO EXPLAIN

### A. System Overview
**Explain:**
- "I was assigned System 2, also known as Signed, which is a Windows Server 2019 Domain Controller. This is a critical system as it's the domain controller for SIGNED.HTB domain. The system only exposes one port - Microsoft SQL Server on port 1433. This is interesting because MSSQL on a domain controller can provide valuable information through NTLM authentication."

**Key Points to Cover:**
- System is Windows Server 2019 Domain Controller
- Only one port open (1433 - MSSQL)
- Domain information: SIGNED.HTB, computer name DC01
- MSSQL version: Microsoft SQL Server 2022 RC0+
- High-value target due to domain controller role

### B. Reconnaissance Methodology
**Explain:**
- "I started with comprehensive port scanning. Interestingly, this system only has one open port - MSSQL on 1433. I performed detailed service enumeration using Nmap scripts specifically designed for MSSQL to gather version information and NTLM authentication data."

**Commands to Mention:**
```bash
nmap -sC -sV 10.10.11.90          # Initial scan
nmap -p- --min-rate 2000 10.10.11.90  # Full port scan
nmap -p 1433 --script ms-sql-info,ms-sql-ntlm-info 10.10.11.90
```

**What to Show:**
- Port scan showing only port 1433 open
- MSSQL version identification
- NTLM information disclosure (domain, computer name, OS version)

### C. MSSQL Enumeration
**Explain:**
- "I used specialized Nmap scripts to enumerate the MSSQL service. The ms-sql-ntlm-info script revealed valuable domain information through NTLM authentication, including the domain name (SIGNED.HTB), computer name (DC01), and Windows version. This information disclosure is valuable for targeted attacks."

**Key Points:**
- NTLM authentication leaks domain information
- Domain: SIGNED.HTB
- Computer: DC01
- OS: Windows Server 2019 (10.0.17763)
- MSSQL version: 2022 RC0+

### D. Vulnerability Identification
**Explain:**
- "The primary vulnerability is the exposed MSSQL service. While MSSQL itself may not have direct vulnerabilities, exposing it to the network without proper firewall protection creates a significant attack surface. I calculated a CVSS score of 6.5 (Medium severity) for this exposure."

**Key Points:**
- Exposed MSSQL service (CVSS 6.5 - Medium)
- Domain information disclosure (CVSS 3.7 - Low)
- Potential for brute-force attacks
- Information disclosure via NTLM

### E. Exploitation Attempts
**Explain:**
- "I attempted multiple exploitation methods. First, I checked for empty passwords on the 'sa' account. Then I performed brute-force attacks using common MSSQL usernames and passwords. I also attempted to connect using Impacket's mssqlclient.py tool."

**Methods Attempted:**
1. **Empty Password Check**: Tested if 'sa' account has empty password
2. **Credential Brute-Force**: Tested common username/password combinations
3. **Connection Attempts**: Tried to establish MSSQL connections
4. **Authentication Method Analysis**: Determined SQL Server vs Windows Authentication

**Commands to Mention:**
```bash
# Empty password check
nmap -p 1433 --script ms-sql-empty-password 10.10.11.90

# Brute force
nmap -p 1433 --script ms-sql-brute --script-args userdb=users.txt,passdb=passwords.txt

# Connection attempt
python3 mssqlclient.py sa@10.10.11.90
```

### F. Challenges and Limitations
**Explain:**
- "The main challenge was the limited attack surface - only one port open. MSSQL requires valid credentials for most operations, and brute-forcing was time-consuming. The system appears to be well-hardened with no obvious default credentials."

### G. Documentation and Evidence
**Explain:**
- "I documented everything systematically. I saved all scan outputs, NTLM information, brute-force results, and created comprehensive documentation following professional penetration testing standards."

---

## 3. WHAT THEY ACHIEVED

### ✅ Completed Tasks

#### A. Comprehensive Reconnaissance (100% Complete)
- **Port Scanning**: 
  - Full port scan (all 65535 ports)
  - Only port 1433 (MSSQL) found open
  - Confirmed no other services exposed
- **Service Identification**: 
  - Microsoft SQL Server 2022 RC0+
  - Confirmed via Nmap service detection
- **Domain Information Gathering**:
  - Domain: SIGNED.HTB
  - Computer Name: DC01
  - OS Version: Windows Server 2019 (10.0.17763)
  - Gathered through NTLM authentication
- **Evidence Files**: All scan results saved and organized

#### B. MSSQL Enumeration (95% Complete)
- **Version Identification**: Microsoft SQL Server 2022 RC0+
- **NTLM Information**: Extracted domain, computer, and OS information
- **Authentication Methods**: Analyzed SQL Server authentication capabilities
- **Empty Password Check**: Tested for default empty passwords
- **Service Configuration**: Analyzed MSSQL service settings

#### C. Vulnerability Analysis (90% Complete)
- **Vulnerability Research**: Researched MSSQL 2022 vulnerabilities
- **CVSS Scoring**: 
  - Exposed MSSQL Service: CVSS 6.5 (Medium)
  - Domain Information Disclosure: CVSS 3.7 (Low)
- **Risk Assessment**: Assessed impact of exposed database service
- **Exploit Database Search**: Searched for MSSQL exploits
- **Remediation Recommendations**: Provided detailed fix recommendations

#### D. Exploitation Attempts (70% Complete)
- **Empty Password Testing**: Checked for default empty passwords
- **Credential Brute-Force**: 
  - Created wordlists for MSSQL usernames (sa, admin, administrator, sql, etc.)
  - Created password wordlists (common passwords)
  - Performed automated brute-force attacks
- **Connection Attempts**: Attempted MSSQL connections using various tools
- **Authentication Analysis**: Determined authentication requirements

#### E. Professional Documentation (95% Complete)
- **Scripts Created**: 
  - `system2_signed_complete.sh` - Full reconnaissance and exploitation script
- **Evidence Organization**: All outputs saved in organized directories
- **Report Sections**: Findings documented in final report
- **CVSS Calculations**: All vulnerabilities scored professionally
- **NTLM Information**: Documented information disclosure findings

### 📊 Key Achievements

1. **Thorough Reconnaissance**: Complete system enumeration despite limited attack surface
2. **Domain Information Disclosure**: Successfully extracted domain information via NTLM
3. **Professional Methodology**: Followed PTES framework throughout
4. **Comprehensive Documentation**: All findings documented with evidence
5. **Security Assessment**: Properly assessed risk of exposed database service

---

## 4. CHALLENGES THEY FACED

### Challenge 1: Limited Attack Surface
**Problem:**
- Only one port open (1433 - MSSQL)
- No web services, SMB, RDP, or other common attack vectors
- Very restricted attack surface compared to other systems

**Impact:**
- Limited exploitation options
- Must focus solely on MSSQL
- Fewer attack vectors to test
- More challenging to find entry points

**How They Overcame:**
- Focused on comprehensive MSSQL enumeration
- Used specialized Nmap scripts for MSSQL
- Extracted valuable information through NTLM
- Documented limited attack surface as a finding

### Challenge 2: Authentication Required
**Problem:**
- MSSQL requires valid credentials for most operations
- No anonymous access possible
- Default credentials did not work
- Brute-forcing is time-consuming and may trigger account lockouts

**Impact:**
- Could not access database without credentials
- Limited to enumeration and information gathering
- Could not test database exploitation techniques
- Had to rely on external information disclosure

**How They Overcame:**
- Performed comprehensive brute-force attempts
- Tested for empty passwords
- Analyzed authentication methods
- Documented authentication requirements
- Prepared exploitation methodology for when credentials are found

### Challenge 3: Domain Controller Security
**Problem:**
- System is a Domain Controller (high-value target)
- Likely has enhanced security measures
- Standard attack methods may not work
- Higher risk of detection

**Impact:**
- More challenging to exploit
- Security measures likely hardened
- Need to be more careful with attacks
- May have monitoring in place

**How They Overcame:**
- Focused on information gathering
- Used non-intrusive enumeration methods
- Documented security posture
- Provided appropriate risk assessment

### Challenge 4: MSSQL Version-Specific Research
**Problem:**
- MSSQL Server 2022 RC0+ is relatively new
- Limited exploit availability for this specific version
- Need to research version-specific vulnerabilities
- May require different techniques than older versions

**Impact:**
- Less known exploits available
- Need to research newer attack methods
- May require custom exploitation techniques
- More time-consuming research

**How They Overcame:**
- Researched MSSQL 2022 vulnerabilities
- Searched exploit databases
- Analyzed general MSSQL attack vectors
- Documented version-specific considerations

### Challenge 5: Information Gathering Limitations
**Problem:**
- Limited to NTLM information disclosure
- Cannot enumerate database structure without credentials
- Cannot test SQL injection without access
- Limited to external enumeration

**Impact:**
- Less information gathered than desired
- Cannot demonstrate full exploitation
- Limited evidence of vulnerabilities
- Must focus on exposure assessment

**How They Overcame:**
- Maximized information extraction from NTLM
- Documented all available information
- Provided comprehensive risk assessment
- Focused on remediation recommendations

---

## 5. WHAT THEY DONE (Detailed Breakdown)

### Phase 1: Initial Reconnaissance

**Actions Taken:**
1. **Connectivity Testing**
   - Ping tests to verify system accessibility
   - Network latency measurement
   - Basic connectivity confirmation

2. **Port Scanning**
   ```bash
   nmap -sC -sV 10.10.11.90
   nmap -p- --min-rate 2000 10.10.11.90
   ```
   - Initial scan with default scripts
   - Full port scan (all 65535 ports)
   - Confirmed only port 1433 open

3. **Service Identification**
   - Microsoft SQL Server 2022 RC0+
   - Confirmed via Nmap service detection
   - No other services found

**Evidence Created:**
- `signed_nmap_full.txt` - Full port scan results
- `signed_initial_scan.txt` - Initial scan output
- Port scan screenshots and outputs

### Phase 2: MSSQL Enumeration

**Actions Taken:**
1. **MSSQL Information Gathering**
   ```bash
   nmap -p 1433 --script ms-sql-info,ms-sql-ntlm-info 10.10.11.90
   ```
   - Retrieved MSSQL version information
   - Extracted NTLM authentication data
   - Analyzed service configuration

2. **NTLM Information Extraction**
   - Domain: SIGNED.HTB
   - Computer Name: DC01
   - OS Version: Windows Server 2019 (10.0.17763)
   - Product Version information

3. **Authentication Method Analysis**
   - Determined SQL Server Authentication support
   - Analyzed Windows Authentication capabilities
   - Checked for mixed mode authentication

**Evidence Created:**
- `signed_mssql_info.txt` - MSSQL version and NTLM info
- NTLM information documentation
- Service configuration details

### Phase 3: Vulnerability Research

**Actions Taken:**
1. **CVE Research**
   ```bash
   searchsploit mssql
   searchsploit "microsoft sql server"
   ```
   - Searched Exploit-DB for MSSQL exploits
   - Researched SQL Server 2022 vulnerabilities
   - Analyzed CVE databases

2. **CVSS Scoring**
   - Exposed MSSQL Service: CVSS 6.5 (Medium)
     - Vector: AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:L
   - Domain Information Disclosure: CVSS 3.7 (Low)
   - Assessed impact and exploitability

3. **Risk Assessment**
   - Assessed risk of exposed database service
   - Evaluated information disclosure impact
   - Considered domain controller implications

**Evidence Created:**
- `mssql_exploits.txt` - Exploit search results
- CVSS calculation documentation
- Vulnerability research notes

### Phase 4: Exploitation Attempts

**Actions Taken:**
1. **Empty Password Check**
   ```bash
   nmap -p 1433 --script ms-sql-empty-password 10.10.11.90
   ```
   - Tested if 'sa' account has empty password
   - Checked for default configurations
   - Analyzed authentication requirements

2. **Credential Brute-Force**
   ```bash
   # Created wordlists
   users: sa, admin, administrator, sql, sqladmin, mssql, dbadmin, backup
   passwords: password, Password123, P@ssw0rd, admin, Admin123, Welcome123
   
   nmap -p 1433 --script ms-sql-brute \
     --script-args userdb=users_mssql.txt,passdb=pass_mssql.txt
   ```
   - Created MSSQL-specific username wordlist
   - Created password wordlist
   - Performed automated brute-force attacks

3. **Connection Attempts**
   ```bash
   # Using Impacket
   python3 mssqlclient.py sa@10.10.11.90
   python3 mssqlclient.py -p '' sa@10.10.11.90
   ```
   - Attempted connections using Impacket tools
   - Tested various authentication methods
   - Analyzed connection responses

4. **Authentication Analysis**
   - Determined authentication requirements
   - Analyzed failed login responses
   - Documented authentication methods

**Evidence Created:**
- `mssql_empty_password.txt` - Empty password check results
- `mssql_brute.txt` - Brute-force results
- Connection attempt logs
- Authentication analysis documentation

### Phase 5: Documentation and Reporting

**Actions Taken:**
1. **Script Creation**
   - `system2_signed_complete.sh` - Full reconnaissance and exploitation script
   - Automated MSSQL enumeration
   - Brute-force automation

2. **Evidence Organization**
   - Created directory structure
   - Saved all scan outputs
   - Organized findings by phase

3. **Report Writing**
   - Documented all findings
   - Created CVSS scores
   - Provided remediation recommendations

4. **Methodology Documentation**
   - Documented PTES framework usage
   - Explained each phase
   - Created step-by-step guides

**Evidence Created:**
- Complete documentation structure
- All evidence files organized
- Report sections completed
- Methodology documentation

---

## 6. KEY FINDINGS SUMMARY

### Vulnerabilities Identified

#### VULN-S2-001: Exposed MSSQL Service
- **Severity**: MEDIUM
- **CVSS Score**: 6.5
- **Description**: MSSQL service exposed to network without additional firewall protection
- **Impact**: 
  - Potential brute-force attacks
  - Information disclosure via NTLM
  - Database enumeration if credentials found
- **Status**: Documented, requires credentials for exploitation

#### VULN-S2-002: Domain Information Disclosure
- **Severity**: LOW
- **CVSS Score**: 3.7
- **Description**: Domain information exposed via NTLM authentication
- **Impact**: Aids in targeted attacks, domain reconnaissance
- **Status**: Information successfully extracted

### Services Identified
- **MSSQL (Port 1433)**: Microsoft SQL Server 2022 RC0+
  - Domain: SIGNED.HTB
  - Computer: DC01
  - OS: Windows Server 2019

### Attack Vectors
1. **Credential Brute-Force** (Primary) - Tested, no success
2. **Empty Password** - Tested, not found
3. **Information Disclosure** - Successfully extracted domain info
4. **Database Enumeration** - Requires credentials

---

## 7. REMEDIATION RECOMMENDATIONS

### Priority 1: Restrict MSSQL Access
- Implement firewall rules to restrict MSSQL access
- Use VPN for remote database access
- IP whitelisting for database connections
- Timeline: Within 24-48 hours

### Priority 2: Authentication Hardening
- Disable SQL Server Authentication (use Windows auth only)
- Implement strong password policy
- Enable account lockout policies
- Disable 'sa' account if not needed

### Priority 3: Security Hardening
- Enable database auditing
- Implement encryption for data in transit
- Regular security updates
- Monitor for suspicious activity

---

## 8. PRESENTATION TIPS

### What to Emphasize
1. **Limited Attack Surface**: Show how you maximized information gathering from single port
2. **Domain Information Disclosure**: Highlight NTLM information extraction
3. **Professional Methodology**: Show PTES framework usage
4. **Security Assessment**: Explain risk assessment of exposed database
5. **Documentation Quality**: Show organized evidence

### What to Show
- Port scan showing only MSSQL open
- NTLM information extraction
- CVSS calculations
- Brute-force attempts
- Evidence organization

### How to Explain Challenges
- Be honest about limited attack surface
- Explain how you maximized information gathering
- Show problem-solving approach
- Demonstrate understanding of domain controller security

### Time Management
- **Reconnaissance**: 25% of time
- **MSSQL Enumeration**: 30% of time
- **Vulnerability Research**: 20% of time
- **Exploitation Attempts**: 15% of time
- **Documentation**: 10% of time

---

## 9. CONCLUSION

**Student 2 successfully completed comprehensive reconnaissance and vulnerability analysis on System 2 (Signed). Despite the limited attack surface (only one port open), the student demonstrated:**

- ✅ Professional penetration testing methodology
- ✅ Effective use of specialized MSSQL enumeration tools
- ✅ Successful information disclosure via NTLM
- ✅ Comprehensive vulnerability research and CVSS scoring
- ✅ Thorough documentation and evidence organization
- ✅ Clear understanding of domain controller security implications
- ✅ Professional reporting and remediation recommendations

**The work demonstrates strong skills in working with limited attack surfaces and extracting maximum information from minimal exposure. The domain information disclosure finding is particularly valuable for understanding the target environment.**

---

**End of Student 2 Presentation Guide**

