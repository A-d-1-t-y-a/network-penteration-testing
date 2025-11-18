# System 4: Lock - Initial Scan Findings

## System Information
- **IP**: 10.129.6.226
- **Hostname**: Lock
- **OS**: Windows Server (version 10.0.20348)
- **Platform**: HackTheBox

## Open Ports and Services

### Port 80 - HTTP (IIS 10.0)
- **Service**: Microsoft IIS httpd 10.0
- **Methods**: GET, HEAD, POST, OPTIONS, **TRACE** (potentially risky)
- **Notes**: Standard Windows web server

### Port 445 - SMB
- **Service**: Microsoft-DS (SMB2)
- **SMB Version**: SMB 2.x/3.x
- **Security Mode**: Message signing enabled but not required
- **Vulnerabilities Checked**:
  - MS10-054: Not vulnerable
  - MS10-061: Could not verify (connection issue)

### Port 3000 - Gitea
- **Service**: Gitea (Git repository service)
- **Important**: This is a self-hosted Git service
- **Cookies**: `i_like_gitea`, `_csrf` (CSRF protection enabled)
- **Headers**: `X-Frame-Options: SAMEORIGIN`, `X-Content-Type-Options: nosniff`
- **Methods**: GET, HEAD (OPTIONS returns 405)
- **Notes**: This is the most interesting service - may contain repositories with sensitive information

### Port 3389 - RDP
- **Service**: Microsoft Terminal Services
- **SSL Certificate**: commonName=Lock
- **NTLM Info**:
  - Target_Name: LOCK
  - NetBIOS_Domain_Name: LOCK
  - NetBIOS_Computer_Name: LOCK
  - DNS_Domain_Name: Lock
  - DNS_Computer_Name: Lock
  - Product_Version: 10.0.20348
  - System_Time: 2025-11-18T06:16:15+00:00

## Clock Skew
- Mean: 7 seconds
- The target system time is approximately 7 seconds ahead of the scanning system

## Summary of Services

| Port | Service | Version | Notes |
|------|---------|---------|-------|
| 80 | HTTP | IIS 10.0 | Windows web server, TRACE method enabled |
| 445 | SMB | Microsoft-DS | SMB2/3, signing not required |
| 3000 | Gitea | Unknown version | **High priority** - Git service |
| 3389 | RDP | Terminal Services | Remote desktop enabled |

## Attack Surface Analysis

### High Priority
1. **Gitea (Port 3000)**:
   - Check for public repositories
   - Look for credentials in repos
   - Check for Gitea CVEs
   - Try default credentials
   - Enumerate users via API

### Medium Priority
2. **IIS (Port 80)**:
   - Directory enumeration
   - File upload vulnerabilities
   - .aspx execution vulnerabilities
   - TRACE method (HTTP verb tampering)

3. **SMB (Port 445)**:
   - Anonymous/null session access
   - Enumerate shares
   - Check for weak credentials
   - SMB vulnerabilities

### Low Priority
4. **RDP (Port 3389)**:
   - Brute force (last resort)
   - Check for known RDP vulnerabilities
   - Network Level Authentication (NLA) status

## Next Steps

1. **Gitea Enumeration**:
   ```bash
   curl -s http://10.129.6.226:3000/
   curl -s http://10.129.6.226:3000/api/v1/version
   curl -s http://10.129.6.226:3000/explore/repos
   curl -s http://10.129.6.226:3000/api/v1/users/search
   ```

2. **IIS Enumeration**:
   ```bash
   curl -s http://10.129.6.226/
   ffuf -u http://10.129.6.226/FUZZ -w wordlist.txt
   ```

3. **SMB Enumeration**:
   ```bash
   smbclient -L //10.129.6.226/ -N
   ```

4. **Exploit Search**:
   ```bash
   searchsploit gitea
   searchsploit "iis 10"
   ```

## Recommendations

- Focus on Gitea first - it's the most unusual service and likely the attack vector
- Check for public repositories or user enumeration
- Look for Gitea version-specific exploits
- Only try brute force as a last resort

