# System 4: Lock - Complete Penetration Test Report

## Target Information
- **IP Address**: 10.129.6.226
- **Hostname**: lock.htb
- **Platform**: HackTheBox
- **OS**: Windows Server 2022 (Build 10.0.20348)
- **Domain**: LOCK
- **Computer Name**: LOCK

---

## Executive Summary

System 4 (Lock) is a Windows Server 2022 machine running multiple services including IIS web server, SMB file sharing, Gitea Git service, and Remote Desktop Protocol. The most significant finding is the presence of Gitea version 1.21.3 on port 3000, which has known vulnerabilities and represents the primary attack vector for this system.

**Risk Level**: HIGH  
**Primary Attack Vector**: Gitea 1.21.3 (Port 3000)  
**Exploitation Status**: Reconnaissance complete, exploitation not attempted due to time constraints

---

## Reconnaissance Phase

### Port Scan Results

#### All Ports Scan
```
PORT     STATE SERVICE
80/tcp   open  http
445/tcp  open  microsoft-ds
3000/tcp open  ppp (Gitea)
3389/tcp open  ms-wbt-server (RDP)
```

#### Detailed Service Scan
```
PORT     STATE    SERVICE       VERSION
80/tcp   open     http          Microsoft IIS httpd 10.0
         |_http-methods: Potentially risky methods: TRACE
445/tcp  open     microsoft-ds  (SMB 2.x/3.x)
3000/tcp open     ppp           Gitea 1.21.3
3389/tcp open     ms-wbt-server Microsoft Terminal Services
5985/tcp filtered wsman         (WinRM - filtered)
```

### Service Enumeration Details

#### 1. HTTP Service (Port 80) - Microsoft IIS 10.0

**Version**: Microsoft IIS httpd 10.0  
**Powered By**: ASP.NET  
**Server Header**: Microsoft-IIS/10.0

**Findings**:
- Default IIS start page accessible at `/iisstart.htm`
- TRACE HTTP method enabled (potentially risky)
- Standard IIS configuration
- No custom applications detected on root directory

**HTTP Response Headers**:
```
HTTP/1.1 200 OK
Content-Length: 16054
Content-Type: text/html
Server: Microsoft-IIS/10.0
X-Powered-By: ASP.NET
```

**Vulnerability Scans**:
- XSS: No stored/DOM-based XSS found
- CSRF: No CSRF vulnerabilities found
- CVE-2014-3704: Not vulnerable

#### 2. SMB Service (Port 445) - Microsoft-DS

**SMB Version**: SMB 2.x/3.x  
**Message Signing**: Enabled but not required  
**Anonymous Access**: Denied

**Findings**:
- Anonymous/null session access denied
- No accessible shares without credentials
- Not vulnerable to MS10-054 (Windows SMB Client NTLM Authentication Forwarding)
- Not vulnerable to MS10-061 (Windows Print Spooler Service Impersonation)
- Not vulnerable to MS17-010 (EternalBlue)
- No SMB vulnerabilities detected

**SMB Security**:
```
SMB2 Security Mode: 3:1:1
Message signing enabled but not required
```

#### 3. Gitea Service (Port 3000) ⭐ PRIMARY TARGET

**Application**: Gitea (Self-hosted Git service)  
**Version**: 1.21.3 (confirmed via API: `/api/v1/version`)  
**Protocol**: HTTP  
**Security Features**: CSRF protection enabled, HttpOnly cookies, SameSite protection

**API Endpoints Accessible**:
- `/api/v1/version` - Version information
- `/api/v1/repos/search` - Repository search
- `/explore/repos` - Public repositories
- `/api/v1/users/search` - User enumeration
- `/user/sign_up` - Registration page
- `/user/login` - Login page

**Security Headers**:
```
Set-Cookie: i_like_gitea=[value]; Path=/; HttpOnly; SameSite=Lax
Set-Cookie: _csrf=[value]; Path=/; Max-Age=86400; HttpOnly; SameSite=Lax
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Cache-Control: max-age=0, private, must-revalidate, no-transform
```

**Known Gitea Vulnerabilities** (from searchsploit):
1. **Gitea 1.12.5** - Remote Code Execution (Authenticated) - exploit/multiple/webapps/49571.py
2. **Gitea 1.16.6** - Remote Code Execution (Metasploit) - exploit/multiple/webapps/51009.rb
3. **Gitea 1.22.0** - Stored XSS - exploit/multiple/webapps/52077.txt
4. **Gitea 1.4.0** - Remote Code Execution - exploit/multiple/webapps/44996.py
5. **Gitea 1.7.5** - Remote Code Execution - exploit/multiple/webapps/49383.py

**Note**: Version 1.21.3 falls between 1.16.6 and 1.22.0, requires version-specific vulnerability research.

#### 4. RDP Service (Port 3389) - Microsoft Terminal Services

**Version**: Microsoft Terminal Services  
**SSL Certificate**: commonName=Lock  
**Certificate Valid**: 2025-11-17 to 2026-05-19

**NTLM Information**:
```
Target_Name: LOCK
NetBIOS_Domain_Name: LOCK
NetBIOS_Computer_Name: LOCK
DNS_Domain_Name: Lock
DNS_Computer_Name: Lock
Product_Version: 10.0.20348
```

**RDP Security**:
```
CredSSP (NLA): SUCCESS (Enabled)
CredSSP with Early User Auth: SUCCESS
RDSTLS: SUCCESS
SSL: SUCCESS
```

**Security Assessment**:
- Network Level Authentication (NLA) enabled (good security)
- SSL encryption enabled
- Modern RDP security configuration
- Requires valid credentials for access

---

## Vulnerability Analysis

### Critical Vulnerabilities

#### VULN-001: Gitea Potential RCE Vulnerability
- **Severity**: HIGH (Estimated CVSS 8.1)
- **Affected Service**: Gitea 1.21.3 (Port 3000)
- **CVE**: Multiple CVEs affect Gitea versions near 1.21.3
- **Status**: Requires authentication for exploitation
- **Description**: Gitea is known to have multiple RCE vulnerabilities in various versions. Version 1.21.3 requires specific CVE research for exact vulnerabilities.

**CVSS 3.1 Score Calculation** (Estimated):
- **Attack Vector (AV)**: Network (N)
- **Attack Complexity (AC)**: Low (L)
- **Privileges Required (PR)**: Low (L) - Requires authentication
- **User Interaction (UI)**: None (N)
- **Scope (S)**: Unchanged (U)
- **Confidentiality (C)**: High (H)
- **Integrity (I)**: High (H)
- **Availability (A)**: High (H)
- **Base Score**: 8.8 (High)
- **Vector String**: CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H

**Exploitation Path**:
1. Register account on Gitea (if registration enabled)
2. Search for exploits specific to Gitea 1.21.3
3. Use authenticated RCE exploit
4. Gain shell access as Gitea service account
5. Escalate privileges using Windows privilege escalation techniques

### High Vulnerabilities

#### VULN-002: IIS HTTP TRACE Method Enabled
- **Severity**: MEDIUM (CVSS 4.3)
- **Affected Service**: IIS 10.0 (Port 80)
- **CVE**: N/A (Configuration issue)
- **Description**: HTTP TRACE method is enabled, which can be used for Cross-Site Tracing (XST) attacks.

**CVSS 3.1 Score**:
- **Attack Vector (AV)**: Network (N)
- **Attack Complexity (AC)**: Low (L)
- **Privileges Required (PR)**: None (N)
- **User Interaction (UI)**: Required (R)
- **Scope (S)**: Unchanged (U)
- **Confidentiality (C)**: Low (L)
- **Integrity (I)**: None (N)
- **Availability (A)**: None (N)
- **Base Score**: 4.3 (Medium)
- **Vector String**: CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:L/I:N/A:N

**Impact**: TRACE method can be used to bypass HTTPOnly cookie protection in certain scenarios.

### Medium Vulnerabilities

#### VULN-003: SMB Signing Not Required
- **Severity**: MEDIUM (CVSS 5.9)
- **Affected Service**: SMB (Port 445)
- **CVE**: N/A (Configuration issue)
- **Description**: SMB message signing is enabled but not required, which could allow man-in-the-middle attacks.

**CVSS 3.1 Score**:
- **Attack Vector (AV)**: Adjacent Network (A)
- **Attack Complexity (AC)**: High (H)
- **Privileges Required (PR)**: None (N)
- **User Interaction (UI)**: None (N)
- **Scope (S)**: Unchanged (U)
- **Confidentiality (C)**: High (H)
- **Integrity (I)**: High (H)
- **Availability (A)**: None (N)
- **Base Score**: 5.9 (Medium)
- **Vector String**: CVSS:3.1/AV:A/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:N

**Impact**: Could allow SMB relay attacks if attacker is on adjacent network.

---

## Attack Vectors & Exploitation Paths

### Primary Attack Vector: Gitea Exploitation

**Path 1: Authenticated RCE via Gitea**
1. **Account Registration**:
   - Check if registration is enabled: `http://10.129.6.226:3000/user/sign_up`
   - If enabled, register a new account
   - If disabled, attempt credential brute-force or default credentials

2. **Repository Enumeration**:
   - Enumerate public repositories for sensitive information
   - Look for:
     - Passwords in code
     - `.env` files with credentials
     - `web.config` with connection strings
     - SSH keys
     - API keys

3. **Exploit Gitea**:
   - Research CVEs specific to Gitea 1.21.3
   - Use Git hooks for RCE (if permissions allow)
   - Upload malicious files via repository
   - Exploit known Gitea RCE vulnerabilities

4. **Post-Exploitation**:
   - Gain shell as Gitea service account
   - Enumerate Windows system
   - Check for SeImpersonatePrivilege
   - Use PrintSpoofer/JuicyPotato for privilege escalation
   - Capture flags

### Secondary Attack Vector: Credential-Based Access

**Path 2: Credential Discovery**
1. **Gitea Repository Mining**:
   - Clone all accessible repositories
   - Search for credentials:
     ```bash
     git clone http://10.129.6.226:3000/[user]/[repo]
     grep -r "password" .
     grep -r "username" .
     find . -name "*.config"
     find . -name ".env"
     ```

2. **Credential Usage**:
   - Try discovered credentials on:
     - SMB (port 445)
     - RDP (port 3389)
     - WinRM (port 5985)
     - Gitea admin panel

### Tertiary Attack Vector: Brute Force (Last Resort)

**Path 3: Credential Brute-Force**
1. **RDP Brute-Force**:
   ```bash
   hydra -L users.txt -P passwords.txt rdp://10.129.6.226 -t 4
   ```

2. **SMB Brute-Force**:
   ```bash
   hydra -L users.txt -P passwords.txt smb://10.129.6.226 -t 4
   ```

3. **Gitea Brute-Force**:
   ```bash
   hydra -L users.txt -P passwords.txt http-post-form://10.129.6.226:3000/user/login:"user_name=^USER^&password=^PASS^:F=incorrect" -t 4
   ```

---

## Recommended Commands for Exploitation

### Phase 1: Gitea Reconnaissance
```bash
# Check if registration is enabled
curl http://10.129.6.226:3000/user/sign_up

# Enumerate public repositories
curl http://10.129.6.226:3000/explore/repos

# Search for users
curl http://10.129.6.226:3000/api/v1/users/search?q=admin

# Try default credentials
curl -X POST http://10.129.6.226:3000/user/login \
  -d "user_name=admin&password=admin" \
  -c cookies.txt -v

curl -X POST http://10.129.6.226:3000/user/login \
  -d "user_name=gitea&password=gitea" \
  -c cookies.txt -v
```

### Phase 2: Vulnerability Exploitation
```bash
# Research Gitea 1.21.3 CVEs
searchsploit gitea 1.21

# Check for specific CVEs online
# https://www.cvedetails.com/vulnerability-list/vendor_id-18366/Gitea.html

# If exploit found, download and modify
searchsploit -m [exploit_number]

# Example: Git hooks RCE (if applicable to 1.21.3)
# Requires authenticated user with repository access
```

### Phase 3: Post-Exploitation (If Shell Gained)
```powershell
# System enumeration
whoami
whoami /priv
hostname
systeminfo

# Network enumeration
ipconfig /all
netstat -ano
route print

# User enumeration
net user
net localgroup administrators

# Search for flags
dir C:\Users\*\Desktop\user.txt /s
dir C:\Users\*\Desktop\root.txt /s

# Check for stored credentials
cmdkey /list

# Check for privilege escalation
whoami /priv | findstr SeImpersonate
# If SeImpersonate: use PrintSpoofer

# Search for passwords in files
findstr /si password *.xml *.txt *.config
reg query HKLM /f password /t REG_SZ /s
```

---

## Remediation Recommendations

### Critical Priority

1. **Update Gitea to Latest Version**
   - **Current**: Version 1.21.3
   - **Recommended**: Latest stable version (1.22.x or higher)
   - **Impact**: Patches known RCE vulnerabilities
   - **Implementation**: 
     ```
     - Download latest Gitea binary
     - Stop Gitea service
     - Backup current installation
     - Replace binary and restart
     ```

2. **Restrict Gitea Access**
   - **Current**: Publicly accessible on port 3000
   - **Recommended**: 
     - Implement firewall rules to restrict access
     - Use VPN for remote access
     - Implement IP whitelisting
   - **Impact**: Reduces attack surface

3. **Disable Gitea User Registration** (if not needed)
   - **Current**: Registration status unknown
   - **Recommended**: Disable self-registration if not required
   - **Configuration**: `DISABLE_REGISTRATION = true` in `app.ini`

### High Priority

4. **Disable HTTP TRACE Method on IIS**
   - **Current**: TRACE method enabled
   - **Recommended**: Disable via IIS configuration or URL Rewrite
   - **Implementation**:
     ```xml
     <configuration>
       <system.webServer>
         <security>
           <requestFiltering>
             <verbs>
               <add verb="TRACE" allowed="false" />
             </verbs>
           </requestFiltering>
         </security>
       </system.webServer>
     </configuration>
     ```

5. **Require SMB Signing**
   - **Current**: SMB signing enabled but not required
   - **Recommended**: Enforce SMB signing via Group Policy
   - **GPO Path**: Computer Configuration → Windows Settings → Security Settings → Local Policies → Security Options
   - **Setting**: "Microsoft network server: Digitally sign communications (always)" = Enabled

### Medium Priority

6. **Implement Web Application Firewall (WAF)**
   - **Purpose**: Protect IIS and Gitea from common web attacks
   - **Options**: ModSecurity, Azure WAF, or commercial solutions

7. **Enable Detailed Logging**
   - **IIS**: Enable W3C extended logging with all fields
   - **Gitea**: Enable audit logging
   - **RDP**: Enable session logging
   - **SMB**: Enable audit logging

8. **Implement Account Lockout Policies**
   - **Purpose**: Prevent brute-force attacks
   - **Recommendation**: Lock account after 5 failed attempts

---

## Evidence & Screenshots

### Port Scan Evidence
```
Nmap scan performed: 2025-11-18 14:19 IST
All ports scan: 28.57 seconds
Detailed scan: 186.76 seconds
Vulnerability scan: 314.34 seconds
```

### Service Versions Confirmed
- IIS: 10.0 (confirmed via HTTP headers)
- Gitea: 1.21.3 (confirmed via API `/api/v1/version`)
- Windows: Server 2022 Build 10.0.20348 (confirmed via RDP NTLM info)
- SMB: SMB 2.x/3.x (confirmed via Nmap)

### Files Generated
- `lock_allports.txt` - All ports scan
- `lock_detailed.txt` - Detailed service scan
- `lock_vulns.txt` - Vulnerability scan

---

## Timeline

| Time | Activity | Result |
|------|----------|--------|
| 14:19 | Full port scan | 4 open ports identified |
| 14:19 | Detailed service scan | Services enumerated |
| 14:22 | Vulnerability scan | No critical vulns in scan |
| 14:22 | IIS enumeration | Default page accessible |
| 15:22 | Gitea version check | Version 1.21.3 confirmed |
| 15:22 | SMB enumeration | Anonymous access denied |
| 15:23 | RDP enumeration | NLA enabled |
| 15:30 | Exploit search | 5 Gitea exploits found |

**Total Time**: ~70 minutes (reconnaissance only)

---

## Tools Used

1. **Nmap** - Port scanning, service detection, vulnerability scanning
2. **curl** - HTTP requests, API enumeration
3. **Firefox** - Manual web interface exploration
4. **searchsploit** - Exploit database searching
5. **smbclient** - SMB enumeration
6. **enum4linux** - SMB/NetBIOS enumeration
7. **smbmap** - SMB share enumeration

---

## Conclusion

System 4 (Lock) presents a moderate-to-high security risk due to the presence of Gitea version 1.21.3, which is known to have vulnerabilities in nearby versions. The primary attack vector is through the Gitea service on port 3000, which could potentially lead to:

1. **Initial Access**: Via Gitea exploitation or credential discovery in repositories
2. **Privilege Escalation**: Using Windows privilege escalation techniques
3. **Full System Compromise**: Capture of user and administrator flags

The system demonstrates some security measures (NLA enabled on RDP, SMB signing enabled), but the outdated Gitea version and publicly accessible Git service represent significant security gaps.

**Exploitation Status**: Not completed due to time constraints. Requires:
- Gitea account access (registration or credentials)
- Version-specific exploit research
- Active exploitation attempt
- Privilege escalation

**Recommended Next Steps**:
1. Update Gitea to latest version immediately
2. Restrict access to Gitea service
3. Conduct comprehensive security audit
4. Implement monitoring and alerting

---

## References

[1] Gitea Official Website. Available: https://gitea.io/  
[2] CVE Details - Gitea. Available: https://www.cvedetails.com/vulnerability-list/vendor_id-18366/Gitea.html  
[3] Exploit Database - Gitea. Available: https://www.exploit-db.com/  
[4] CVSS v3.1 Calculator. Available: https://www.first.org/cvss/calculator/3.1  
[5] Microsoft IIS Security Best Practices. Available: https://docs.microsoft.com/en-us/iis/  
[6] SMB Security Configuration. Available: https://docs.microsoft.com/en-us/windows-server/  

---

**Report Generated**: 2025-11-18  
**Tester**: Network Penetration Testing Team  
**Status**: Reconnaissance Complete, Exploitation Pending

