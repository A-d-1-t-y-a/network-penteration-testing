# Systems Progress (Live Notes)

## System 1: Editor (HackTheBox) — Released 02 Aug 2025
- IP: 10.10.11.80
- OS: Linux (Ubuntu)
- Open ports: 22 (OpenSSH 8.9p1), 80 (nginx 1.18.0), 8080 (Jetty 10.0.20)
- Web: `editor.htb` (React SPA), `/assets` present; JS bundle download timing out (likely rate/size or server-side throttle)
- XWiki (port 8080): REST reachable, version `<version>15.10.8</version>`; UI appears to still be initializing
- Evidence:
  - `DOCUMENTATION/system1/reconnaissance/editor_nmap.txt`
  - `DOCUMENTATION/system1/reconnaissance/xwiki_rest_version.txt`

Next steps (pending UI readiness):
- Poll `/xwiki` UI for login page, enumerate login/registration, test default creds once
- Enumerate REST endpoints for spaces/pages; assess upload/macro/template vectors when UI is ready

---

## System 2: Signed (HackTheBox) — Released 11 Oct 2025
- IP: 10.10.11.90
- OS: Windows (domain hints below)
- Open ports: 1433/tcp (Microsoft SQL Server 2022 16.00.1000.00; RC0+)
- MSSQL NTLM info:
  - Target_Name / NetBIOS_Domain_Name: SIGNED
  - NetBIOS_Computer_Name: DC01
  - DNS domain/computer: SIGNED.HTB / DC01.SIGNED.HTB
  - Product_Version: 10.0.17763
- UDP 1434: open|filtered
- Brute/empty checks:
  - Empty password: none
  - Small credential spray (6×8): none
- Evidence:
  - `DOCUMENTATION/system2/reconnaissance/signed_nmap_full.txt`
  - `DOCUMENTATION/system2/reconnaissance/signed_mssql_info.txt`
  - `DOCUMENTATION/system2/reconnaissance/signed_mssql_empty.txt`
  - `DOCUMENTATION/system2/reconnaissance/signed_mssql_brute.txt`

Next steps:
- Expand username/password spray (educated guesses for domain service accounts, e.g., `SQLSvc`, `MSSQLSvc`, `svc_mssql`, `backup`, `dbadmin`, with seasonal and org-themed passwords)
- If credentials obtained, connect with `impacket-mssqlclient` and attempt `xp_cmdshell`; otherwise enumerate databases/permissions via authenticated scripts

---

## System 3: Soulmate (HackTheBox) — Released 06 Sep 2025
- IP: 10.10.11.86
- OS: Linux (Ubuntu)
- Open ports: 22 (OpenSSH 8.9p1), 80 (nginx 1.18.0), 4369 (epmd - Erlang Port Mapper Daemon)
- Web: Redirects to `soulmate.htb` (need to add to /etc/hosts)
- Directory enumeration: Many paths return 302 redirects (154 bytes each) - likely redirect loop or filtering
- Valid paths found: `/assets` (301), `/index.html` (200)
- Evidence:
  - `DOCUMENTATION/system3/reconnaissance/s3_initial.txt`
  - `DOCUMENTATION/system3/reconnaissance/s3_full.txt`
  - `DOCUMENTATION/system3/reconnaissance/s3_ffuf_common.txt`

Current status:
- ✓ Hosts file updated: soulmate.htb -> 10.10.11.86
- ✓ Redirect confirmed: 302 to http://soulmate.htb/
- ✓ **Backend now responding**: Changed from 504 Gateway Timeout to 404 Not Found (progress!)
- ✓ Port 4369 confirmed: Erlang Port Mapper Daemon (epmd)
- ⚠️ epmd query failed: erlang-base package unavailable (Kali repo 404 errors)
- ✓ Port scan: No additional Erlang ports in common ranges (4000-4010, 8000-8010)

Analysis:
- Backend service initialized (no longer timing out)
- Common endpoints (/api/, /health, /status) return 404 (endpoints don't exist, not service down)
- Need to find correct application endpoints via enumeration

Reconnaissance completed:
- ✓ Port scan: 22 (SSH), 80 (nginx), 4369 (epmd)
- ✓ Web enumeration: Only /assets found (301 redirect)
- ⚠️ Backend service: Intermittent 504 Gateway Timeouts
- ⚠️ Limited attack surface: Most paths return 404
- ✓ Directory enumeration: ffuf with common.txt - only /assets found

Status: Initial reconnaissance complete, but backend is unstable. Requires further investigation.

Decision: Moving to System 4 to maintain momentum. Will return to System 3 later.

Evidence saved:
- s3_initial.txt, s3_full.txt, s3_ffuf_results.txt, s3_summary.txt

---

## System 4: Lock (HackTheBox) — <UPDATE_RELEASE_DATE>
- IP: 10.129.6.226
- OS: Windows
- Status: Ready for testing
- Script: `SCRIPTS/system4_lock_complete.sh` (ready to run)

Next steps:
- Run complete reconnaissance script
- Focus on SMB enumeration (port 445)
- Check for RDP (port 3389)
- Enumerate Windows services
- Attempt exploitation based on findings


