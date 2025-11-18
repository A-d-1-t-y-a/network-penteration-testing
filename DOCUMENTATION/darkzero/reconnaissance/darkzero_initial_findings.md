# DarkZero (10.129.7.35) - Initial Reconnaissance Findings

## System Information
- **IP Address**: 10.129.7.35
- **Domain**: darkzero.htb
- **DC Hostname**: DC01.darkzero.htb
- **OS**: Windows (Domain Controller)
- **Build**: 10.0.26100 (Windows Server 2025)

## Open Ports

| Port | Service | Version/Details |
|------|---------|----------------|
| 53 | DNS | Simple DNS Plus |
| 88 | Kerberos | Microsoft Windows Kerberos |
| 135 | MSRPC | Microsoft Windows RPC |
| 139 | NetBIOS-SSN | Microsoft Windows netbios-ssn |
| 389 | LDAP | Active Directory LDAP |
| 445 | SMB | Microsoft-DS (Message signing enabled and required) |
| 464 | kpasswd5 | Kerberos password change |
| 593 | ncacn_http | Microsoft Windows RPC over HTTP 1.0 |
| 636 | LDAPS | LDAP over SSL |
| 1433 | MSSQL | Microsoft SQL Server 2022 RC0+ (16.00.1000.00) |
| 2179 | vmrdp | VMware RDP |
| 3268 | Global Catalog LDAP | |
| 3269 | Global Catalog LDAPS | |
| 5985 | WinRM | Windows Remote Management |
| 9389 | ADWS | Active Directory Web Services |
| 49223-49928 | MSRPC | Multiple dynamic RPC endpoints |

## Domain Information

- **Domain Name**: darkzero.htb
- **NetBIOS Domain**: DARKZERO
- **Domain Controller**: DC01.darkzero.htb
- **Domain Functionality**: 7 (Windows Server 2016)
- **Forest Functionality**: 7
- **DC Functionality**: 10 (Windows Server 2022)

## DNS Records

- `darkzero.htb` → 10.129.7.35, 172.16.20.1
- `dc01.darkzero.htb` → 10.129.7.35, 172.16.20.1
- `_ldap._tcp.darkzero.htb` → SRV record pointing to dc01.darkzero.htb:389
- `_kerberos._tcp.darkzero.htb` → SRV record pointing to dc01.darkzero.htb:88
- `_gc._tcp.darkzero.htb` → SRV record pointing to dc01.darkzero.htb:3268

## Enumerated Users

### Confirmed Users (via ASREPRoast)
- `Administrator` - Does NOT have UF_DONT_REQUIRE_PREAUTH set
- `DC01` - Does NOT have UF_DONT_REQUIRE_PREAUTH set

### Tested Users (not found in Kerberos database)
- `admin`
- `guest`
- `krbtgt`
- `sqlsvc`
- `svc_account`
- `service`
- `test`
- `user`
- `darkzero`

## Services Analysis

### LDAP
- Anonymous bind: ✅ Works (limited access)
- Base DN enumeration: ✅ Works
- User enumeration: ❌ Requires authentication
- Service account enumeration: ❌ Requires authentication

### SMB
- Anonymous access: ✅ Login successful (no shares listed)
- Message signing: Required
- SMBv1: Disabled
- Shares: None accessible anonymously

### MSSQL
- Version: Microsoft SQL Server 2022 RC0+
- Empty password: ❌ Not found
- Windows authentication: Required (untrusted domain error)
- SQL authentication: Requires credentials

### Kerberos
- ASREPRoast: No users without pre-authentication
- Kerberoasting: Requires authenticated LDAP bind

## Attempted Attacks

1. ✅ DNS zone transfer - Failed
2. ✅ LDAP anonymous enumeration - Limited success
3. ✅ ASREPRoast - No vulnerable users found
4. ✅ Kerberoasting - Requires authentication
5. ✅ MSSQL brute force - No credentials found
6. ✅ SMB password spraying - Connection timeouts
7. ✅ MSSQL Windows auth - Untrusted domain error
8. ✅ Web service enumeration - No HTTP/HTTPS services found

## Current Status

**Reconnaissance**: 90% Complete
- ✅ Port scanning complete
- ✅ Service enumeration complete
- ✅ DNS enumeration complete
- ✅ LDAP enumeration (limited)
- ✅ User discovery (partial)
- ❌ Credential discovery - No success
- ❌ Initial access - Not achieved

## Next Steps

1. Try additional username enumeration methods
2. Attempt password spraying with different protocols (WinRM, RDP)
3. Check for default/weak credentials on MSSQL
4. Look for web services on non-standard ports
5. Research known vulnerabilities for Windows Server 2025 / SQL Server 2022
6. Try alternative LDAP enumeration techniques

## Evidence Files

- `drive_initial.txt` - Initial Nmap scan
- `drive_full.txt` - Full port scan
- `darkzero_mssql.txt` - MSSQL service info
- `darkzero_mssql_brute.txt` - MSSQL brute force results
- `darkzero_unknown_ports.txt` - Unknown ports service detection
- `darkzero_vuln_scan.txt` - Vulnerability scan results

