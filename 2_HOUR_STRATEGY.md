# 2-Hour Strategy for Maximum Marks

## Current Progress: ~35-40%
## Target: 70-80% (realistic in 2 hours)

---

## Hour 1: System 4 (Lock) - Complete Exploitation

### 0:00 - 0:15 (15 min): Gitea Enumeration
```bash
# Run these commands
curl -s http://10.129.6.226:3000/ > gitea_home.html
curl -s http://10.129.6.226:3000/api/v1/version
curl -s http://10.129.6.226:3000/explore/repos | tee gitea_repos.html
curl -s http://10.129.6.226:3000/api/v1/users/search
searchsploit gitea
```
**Goal:** Find Gitea version, public repos, users, exploits

### 0:15 - 0:30 (15 min): Analyze & Exploit Gitea
- If version found → search for CVE
- If public repos found → clone and search for credentials
- If users found → try default passwords
- Try: admin/admin, gitea/gitea, lock/lock

### 0:30 - 0:45 (15 min): IIS & SMB Quick Check
```bash
# IIS
curl -s http://10.129.6.226/ | tee iis_home.html
ffuf -u http://10.129.6.226/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 30

# SMB
smbclient -L //10.129.6.226/ -N
```

### 0:45 - 1:00 (15 min): Document System 4 Findings
- Save all output files
- Take screenshots
- Note any credentials found
- **Share findings with me**

---

## Hour 2: Quick Attempts + Documentation

### 1:00 - 1:15 (15 min): System 1 (Editor) - XWiki Exploit
```bash
# Search for XWiki 15.10.8 exploits
searchsploit xwiki 15.10
searchsploit -m <exploit_number>  # if found

# Try default creds
curl -X POST http://10.10.11.80:8080/xwiki/bin/login/XWiki/XWikiLogin \
  -d "j_username=admin&j_password=admin"
```

### 1:15 - 1:30 (15 min): System 2 (Signed) - MSSQL Credentials
```bash
# Create better wordlist
cat > mssql_users.txt <<EOF
sa
admin
sqlsvc
mssql
backup
EOF

cat > mssql_pass.txt <<EOF
password
Password123
P@ssw0rd
Signed123
lock
EOF

# Try connections
for user in sa admin sqlsvc; do
  for pass in password Password123 lock; do
    impacket-mssqlclient $user:$pass@10.10.11.90 -windows-auth
  done
done
```

### 1:30 - 1:45 (15 min): System 3 (Soulmate) - Larger Wordlist
```bash
# Try bigger wordlist
ffuf -u http://soulmate.htb/FUZZ \
  -w ~/Downloads/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \
  -mc 200,204,301,302,307,401,403 -t 50 | head -50
```

### 1:45 - 2:00 (15 min): Final Documentation
- Copy all output files to DOCUMENTATION/
- Organize evidence by system
- Take screenshots of key findings
- **SHARE EVERYTHING WITH ME**

---

## What I'll Do (After You Share Findings)

### I can complete in 30-60 minutes:

1. **Executive Summary** (5 min)
   - Overview of testing
   - Key findings summary
   - Risk assessment

2. **Systems Selection** (5 min)
   - Why these 4 systems
   - OS diversity justification
   - Platform comparison

3. **Methodology** (5 min)
   - PTES framework
   - Risk rating (CVSS)
   - Testing phases

4. **Tools Section** (5 min)
   - Tool matrix
   - Justifications
   - Usage examples

5. **Findings** (20 min) - Most important!
   - Vulnerability descriptions
   - CVSS scores calculation
   - Impact analysis
   - Remediation recommendations
   - Evidence references

6. **Conclusions** (5 min)
   - Summary of findings
   - Limitations
   - Implications

7. **Appendices** (10 min)
   - Step-by-step walkthroughs
   - Command references
   - Screenshots

8. **Format & References** (5 min)
   - IEEE style references
   - Professional formatting

---

## Critical Success Factors

### For 70-80% Marks You Need:

1. **At Least 1 Successful Exploitation** (Critical!)
   - System 4 (Lock) is your best bet
   - Focus here first

2. **Complete Documentation of Attempts**
   - Even failed attempts count
   - Shows methodology

3. **Proper Vulnerability Analysis**
   - CVSS scores (I'll calculate)
   - Severity ratings
   - Remediation

4. **Complete Report Structure**
   - All sections present (I'll write)
   - Professional formatting
   - Evidence included

5. **Clear Presentation**
   - 10-15 slides (I'll create outline)
   - Key findings highlighted

---

## What to Share with Me (After 2 Hours)

### For Each System, Send:
1. All output files from `~/Downloads/system*_*/`
2. Screenshots of important findings
3. Any credentials found
4. Any access gained
5. Any flags captured

### I'll Need:
- Initial scan results
- Web enumeration results
- Exploit search results
- Brute force results
- Any successful exploitation evidence

---

## Backup Plan (If Exploitation Fails)

### You Can Still Get 60-70% By:
1. Complete reconnaissance (you have this)
2. Thorough vulnerability analysis (I'll help)
3. Detailed documentation (I'll write)
4. Professional report (I'll format)
5. Clear presentation (I'll create)

**Key:** Even without successful exploitation, proper documentation of attempts + complete report = passing grade

---

## Start Now!

Run these commands in order:
```bash
# System 4 - Gitea enumeration
curl -s http://10.129.6.226:3000/api/v1/version
curl -s http://10.129.6.226:3000/explore/repos | tee gitea_repos.html
searchsploit gitea
```

Share the output and I'll guide you to the next step!

