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


