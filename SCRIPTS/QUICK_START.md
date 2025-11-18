# QUICK START GUIDE - 2 HOUR COMPLETE TEST

## ⚡ FASTEST APPROACH

### Step 1: Update IPs in Master Script (30 seconds)

Edit `master_recon_all_systems.sh`:
```bash
S1_IP="10.10.11.80"    # System 1: Editor
S2_IP="10.10.11.90"    # System 2: Signed
S3_IP="10.10.11.86"    # System 3: Soulmate
S4_IP="<YOUR_S4_IP>"   # System 4: <YOUR_S4_NAME>
```

### Step 2: Run Master Script (5-10 minutes)
```bash
cd SCRIPTS
chmod +x *.sh
bash master_recon_all_systems.sh
```

This runs ALL initial reconnaissance in parallel for all 4 systems.

### Step 3: While Master Script Runs, Update Individual Scripts

**System 1 (Editor):**
- Already configured in `system1_editor_complete.sh`
- Just run: `bash system1_editor_complete.sh`

**System 2 (Signed):**
- Already configured in `system2_signed_complete.sh`
- Just run: `bash system2_signed_complete.sh`

**System 3 (Soulmate):**
- Already configured in `system3_soulmate_complete.sh`
- Just run: `bash system3_soulmate_complete.sh`

**System 4:**
- Edit `system4_template_complete.sh`:
  - Update `S4_IP="<UPDATE_IP>"`
  - Update `S4_NAME="<UPDATE_HOSTNAME>"`
  - Update `S4_OS="Linux"` or `"Windows"`
- Run: `bash system4_template_complete.sh`

### Step 4: Run Individual Scripts in Parallel (15-30 minutes)

Open 4 terminal windows and run each script:
```bash
# Terminal 1
bash system1_editor_complete.sh

# Terminal 2
bash system2_signed_complete.sh

# Terminal 3
bash system3_soulmate_complete.sh

# Terminal 4
bash system4_template_complete.sh
```

### Step 5: Review Results & Exploit (30-60 minutes)

For each system:
1. Review scan results
2. Identify vulnerabilities
3. Attempt exploitation
4. Document findings

### Step 6: Copy All Results to Documentation

```bash
# Copy results to project
cp -r ~/Downloads/system*_* DOCUMENTATION/
cp -r ~/Downloads/htb_recon_* DOCUMENTATION/
```

## 📋 WHAT EACH SCRIPT COVERS

### Master Script (Parallel Initial Recon)
- ✅ Ping tests
- ✅ Initial Nmap scans
- ✅ Full port scans (background)
- ✅ Basic web enumeration
- ✅ Service-specific enumeration

### Individual Scripts (Complete Testing)
- ✅ Phase 1: Reconnaissance (ports, services, versions)
- ✅ Phase 2: Vulnerability Analysis (exploit search, vuln scans)
- ✅ Phase 3: Exploitation (brute force, credential testing)
- ✅ Phase 4: Post-Exploitation (commands if access gained)

## 🎯 FOR 100% MARKS - CHECKLIST

### Documentation Required:
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

## ⚠️ TIME-SAVING TIPS

1. **Run in Parallel**: Use multiple terminals
2. **Background Jobs**: Long scans run in background
3. **Quick Wordlists**: Use small wordlists for brute force
4. **Focus on Findings**: Document as you go
5. **Prioritize**: Complete 2 systems fully, then move to others

## 📝 AFTER RUNNING SCRIPTS

1. **Review Output Files**: Check all `.txt`, `.json`, `.html` files
2. **Identify Vulnerabilities**: Look for:
   - Default credentials
   - Known exploits
   - Misconfigurations
   - Weak services
3. **Attempt Exploitation**: Try to gain access
4. **Document Everything**: Copy results to `DOCUMENTATION/`
5. **Update Progress**: Update `REPORT/draft/systems_progress.md`

## 🚀 NEXT STEPS AFTER SCRIPTS

Once you have results, share them with me and I'll:
1. Analyze findings
2. Suggest exploitation paths
3. Update documentation
4. Prepare report sections
5. Calculate CVSS scores

