#!/bin/bash
# Next steps for System 3 (Soulmate)

echo "=== Step 1: Try accessing root path again (backend may be up now) ==="
curl -s --max-time 10 http://soulmate.htb/ | head -100
curl -s --max-time 10 http://soulmate.htb/ -v 2>&1 | head -50

echo ""
echo "=== Step 2: Try netcat with different epmd query ==="
# Try different formats
printf "names\n" | nc -w 3 10.10.11.86 4369
printf "port\n" | nc -w 3 10.10.11.86 4369

echo ""
echo "=== Step 3: Directory enumeration with ffuf (common paths) ==="
ffuf -u http://soulmate.htb/FUZZ -w ~/Downloads/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,401,403 -t 50 -o s3_ffuf_common.txt

echo ""
echo "=== Step 4: Try Phoenix/Elixir common paths ==="
for path in "/" "/login" "/register" "/signup" "/api" "/api/v1" "/api/v2" "/dashboard" "/home" "/index" "/welcome"; do
    echo "Testing: $path"
    curl -s --max-time 3 http://soulmate.htb$path | head -5
done

echo ""
echo "=== Step 5: Check for robots.txt, sitemap.xml, etc. ==="
curl -s http://soulmate.htb/robots.txt
curl -s http://soulmate.htb/sitemap.xml
curl -s http://soulmate.htb/.well-known/

echo ""
echo "=== Step 6: Try with different HTTP methods ==="
curl -X OPTIONS -v http://soulmate.htb/ 2>&1 | head -30
curl -X POST -v http://soulmate.htb/ 2>&1 | head -30

