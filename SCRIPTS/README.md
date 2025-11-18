# COMPREHENSIVE PENETRATION TESTING SCRIPTS

## 🚀 QUICK START (2 HOURS)

### Step 1: Create Wordlists (30 seconds)
```bash
cd SCRIPTS
bash create_wordlists.sh
```

### Step 2: Update IPs in Master Script
Edit `master_recon_all_systems.sh`:
- Update `S4_IP` and `S4_NAME` for System 4

### Step 3: Run Master Script (5-10 minutes)
```bash
bash master_recon_all_systems.sh
```
This runs initial reconnaissance for ALL 4 systems in parallel.

### Step 4: Run Individual Complete Scripts (15-30 minutes each)
Open 4 terminal windows and run:
```bash
# Terminal 1
bash system1_editor_complete.sh

# Terminal 2
bash system2_signed_complete.sh

# Terminal 3
bash system3_soulmate_complete.sh

# Terminal 4
bash system4_template_complete.sh  # (update IP first!)
```

### Step 5: Review Results & Exploit
- Check output files in `~/Downloads/system*_*/`
- Identify vulnerabilities
- Attempt exploitation
- Document findings

## 📁 SCRIPT DESCRIPTIONS

### `master_recon_all_systems.sh`
- **Purpose**: Run initial reconnaissance for all 4 systems in parallel
- **Time**: 5-10 minutes
- **Output**: `~/Downloads/htb_recon_*/`
- **What it does**:
  - Ping tests
  - Initial Nmap scans
  - Full port scans (background)
  - Basic web enumeration
  - Service-specific enumeration

### `system1_editor_complete.sh`
- **Purpose**: Complete testing for System 1 (Editor)
- **Time**: 15-30 minutes
- **Output**: `~/Downloads/system1_*/`
- **Covers**:
  - Reconnaissance (ports, services, web)
  - Vulnerability analysis (XWiki exploits)
  - Exploitation (default creds, SSH brute force)
  - Post-exploitation commands

### `system2_signed_complete.sh`
- **Purpose**: Complete testing for System 2 (Signed)
- **Time**: 15-30 minutes
- **Output**: `~/Downloads/system2_*/`
- **Covers**:
  - Reconnaissance (MSSQL, SMB)
  - Vulnerability analysis (MSSQL exploits)
  - Exploitation (MSSQL brute force, xp_cmdshell)
  - Post-exploitation commands

### `system3_soulmate_complete.sh`
- **Purpose**: Complete testing for System 3 (Soulmate)
- **Time**: 15-30 minutes
- **Output**: `~/Downloads/system3_*/`
- **Covers**:
  - Reconnaissance (web, Erlang/epmd)
  - Vulnerability analysis (Erlang/Phoenix exploits)
  - Exploitation (web paths, SSH brute force)
  - Post-exploitation commands

### `system4_template_complete.sh`
- **Purpose**: Complete testing for System 4 (template)
- **Time**: 15-30 minutes
- **Output**: `~/Downloads/system4_*/`
- **Covers**:
  - Reconnaissance (all services)
  - Vulnerability analysis (service-specific)
  - Exploitation (brute force, credential testing)
  - Post-exploitation commands

### `create_wordlists.sh`
- **Purpose**: Create small wordlists for brute forcing
- **Time**: 5 seconds
- **Output**: `~/Downloads/wordlists/`
- **Creates**:
  - `users_small.txt` - Common usernames
  - `pass_small.txt` - Common passwords
  - `users_mssql.txt` - MSSQL usernames
  - `pass_mssql.txt` - MSSQL passwords

## 📋 WHAT EACH SCRIPT COVERS

### Phase 1: Reconnaissance
- ✅ Ping tests
- ✅ Port scans (initial + full)
- ✅ Service version detection
- ✅ Web enumeration
- ✅ Directory brute forcing
- ✅ Service-specific enumeration (SMB, FTP, SSH, etc.)

### Phase 2: Vulnerability Analysis
- ✅ Exploit database searches
- ✅ Nmap vulnerability scripts
- ✅ Service-specific vulnerability checks
- ✅ Version-based exploit identification

### Phase 3: Exploitation
- ✅ Default credential testing
- ✅ Brute force attacks (SSH, SMB, MSSQL)
- ✅ Service-specific exploitation attempts
- ✅ Web application testing

### Phase 4: Post-Exploitation
- ✅ Commands to run if access gained
- ✅ System information gathering
- ✅ Flag collection (user.txt, root.txt)
- ✅ Privilege escalation checks

## 🎯 FOR 100% MARKS

### Documentation Checklist:
- [ ] All scan results saved
- [ ] All commands documented
- [ ] Screenshots of key findings
- [ ] Evidence files organized
- [ ] CVSS scores calculated
- [ ] Remediation recommendations

### Testing Coverage:
- [ ] All 4 systems tested
- [ ] At least 3 from last 3 months
- [ ] Different OS (Windows + Linux)
- [ ] Different services (Web, DB, SMB, etc.)
- [ ] Complete methodology (PTES)
- [ ] Exploitation attempts documented
- [ ] Post-exploitation if access gained

## ⚠️ IMPORTANT NOTES

1. **Update IPs**: Always update IP addresses before running
2. **Hostnames**: Add hostnames to `/etc/hosts` if needed
3. **Wordlists**: Run `create_wordlists.sh` first
4. **Parallel Execution**: Use multiple terminals for speed
5. **Review Results**: Check output files after each script
6. **Document Everything**: Copy results to `DOCUMENTATION/`

## 📝 OUTPUT FILES

Each script creates numbered output files:
- `01_*.txt` - Initial tests
- `02_*.txt` - Port scans
- `03_*.txt` - Full scans
- `04_*.html` - Web pages
- `05_*.txt` - Service enumeration
- `06_*.txt` - Vulnerability scans
- `07_*.txt` - Exploitation attempts
- `08_*.txt` - Brute force results
- etc.

## 🚀 NEXT STEPS

After running scripts:
1. Review all output files
2. Identify vulnerabilities
3. Attempt exploitation
4. Document findings
5. Copy results to `DOCUMENTATION/`
6. Update `REPORT/draft/systems_progress.md`
7. Share results with me for analysis and report writing

## 💡 TIPS

- **Speed**: Run scripts in parallel using multiple terminals
- **Focus**: Complete 2 systems fully, then move to others
- **Documentation**: Document as you go, don't wait until the end
- **Prioritize**: Focus on systems with clear attack paths first

