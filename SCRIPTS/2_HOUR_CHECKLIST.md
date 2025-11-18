# 2-HOUR COMPLETE TEST CHECKLIST

## ⏱️ TIMELINE

### 0:00 - 0:05 Setup (5 minutes)
- [ ] Create wordlists: `bash create_wordlists.sh`
- [ ] Update System 4 IP in `master_recon_all_systems.sh`
- [ ] Update System 4 IP in `system4_template_complete.sh`
- [ ] Add hostnames to `/etc/hosts` if needed
- [ ] Verify all systems are spawned on HTB

### 0:05 - 0:15 Master Recon (10 minutes)
- [ ] Run: `bash master_recon_all_systems.sh`
- [ ] Wait for initial scans to complete
- [ ] Review quick results

### 0:15 - 0:45 Individual Scripts (30 minutes)
- [ ] Open 4 terminal windows
- [ ] Run `system1_editor_complete.sh` in Terminal 1
- [ ] Run `system2_signed_complete.sh` in Terminal 2
- [ ] Run `system3_soulmate_complete.sh` in Terminal 3
- [ ] Run `system4_template_complete.sh` in Terminal 4
- [ ] Wait for all to complete

### 0:45 - 1:15 Review & Exploit (30 minutes)
- [ ] Review System 1 results → Identify vulnerabilities → Attempt exploitation
- [ ] Review System 2 results → Identify vulnerabilities → Attempt exploitation
- [ ] Review System 3 results → Identify vulnerabilities → Attempt exploitation
- [ ] Review System 4 results → Identify vulnerabilities → Attempt exploitation

### 1:15 - 1:45 Document & Organize (30 minutes)
- [ ] Copy all results to `DOCUMENTATION/`
- [ ] Organize evidence files
- [ ] Take screenshots of key findings
- [ ] Update `REPORT/draft/systems_progress.md`
- [ ] Document exploitation attempts

### 1:45 - 2:00 Final Review (15 minutes)
- [ ] Verify all 4 systems have evidence
- [ ] Check all phases covered (Recon → Vuln → Exploit → Post-Exploit)
- [ ] Ensure different OS and services tested
- [ ] Prepare summary for report writing

## 📋 DETAILED CHECKLIST

### System 1: Editor
- [ ] Initial scan complete
- [ ] Full port scan complete
- [ ] Web enumeration complete
- [ ] XWiki version identified
- [ ] XWiki exploits searched
- [ ] Default credentials tested
- [ ] SSH brute force attempted
- [ ] Results documented

### System 2: Signed
- [ ] Initial scan complete
- [ ] Full port scan complete
- [ ] MSSQL info gathered
- [ ] MSSQL exploits searched
- [ ] MSSQL brute force attempted
- [ ] SMB enumeration (if port 445)
- [ ] Results documented

### System 3: Soulmate
- [ ] Initial scan complete
- [ ] Full port scan complete
- [ ] Web enumeration complete
- [ ] Directory brute force complete
- [ ] Erlang/epmd investigated
- [ ] Erlang/Phoenix exploits searched
- [ ] SSH brute force attempted
- [ ] Results documented

### System 4: <UPDATE_NAME>
- [ ] Initial scan complete
- [ ] Full port scan complete
- [ ] Service-specific enumeration complete
- [ ] Vulnerability scans complete
- [ ] Exploitation attempts made
- [ ] Results documented

## 🎯 FOR 100% MARKS

### Required Documentation:
- [ ] All scan results (Nmap, ffuf, etc.)
- [ ] All command outputs
- [ ] Screenshots of:
  - [ ] Port scan results
  - [ ] Web interfaces
  - [ ] Exploitation attempts
  - [ ] Access gained (if any)
  - [ ] Flags found (if any)
- [ ] Evidence files organized by system
- [ ] CVSS scores calculated
- [ ] Remediation recommendations

### Testing Requirements:
- [ ] 4 systems tested
- [ ] At least 3 from last 3 months
- [ ] Different OS (Windows + Linux)
- [ ] Different services (Web, DB, SMB, FTP, SSH, etc.)
- [ ] Complete methodology (PTES phases)
- [ ] Exploitation attempts documented
- [ ] Post-exploitation (if access gained)

### Report Sections:
- [ ] Executive Summary
- [ ] Network/Systems Selection
- [ ] Methodology
- [ ] Tools
- [ ] Findings (with CVSS)
- [ ] Conclusions
- [ ] Reflection
- [ ] Appendices

## ⚠️ CRITICAL REMINDERS

1. **Update IPs**: Always update before running scripts
2. **Hostnames**: Add to `/etc/hosts` if needed
3. **Parallel Execution**: Use multiple terminals
4. **Document As You Go**: Don't wait until the end
5. **Screenshots**: Take screenshots of everything important
6. **Evidence**: Save all output files
7. **Time Management**: Focus on completing 2 systems fully first

## 🚀 AFTER 2 HOURS

Once you have all results:
1. Share all output files with me
2. I'll analyze findings
3. I'll suggest exploitation paths
4. I'll update documentation
5. I'll prepare report sections
6. I'll calculate CVSS scores

## 📝 QUICK COMMANDS

```bash
# Create wordlists
bash SCRIPTS/create_wordlists.sh

# Master recon (all systems)
bash SCRIPTS/master_recon_all_systems.sh

# Individual systems (run in separate terminals)
bash SCRIPTS/system1_editor_complete.sh
bash SCRIPTS/system2_signed_complete.sh
bash SCRIPTS/system3_soulmate_complete.sh
bash SCRIPTS/system4_template_complete.sh

# Copy results to documentation
cp -r ~/Downloads/system*_* DOCUMENTATION/
cp -r ~/Downloads/htb_recon_* DOCUMENTATION/
```

