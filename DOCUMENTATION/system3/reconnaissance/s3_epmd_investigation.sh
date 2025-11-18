#!/bin/bash
# Commands to investigate Erlang Port Mapper and find application ports

# 1. Query epmd for registered nodes
echo "=== Querying epmd for registered nodes ==="
epmd -names -host 10.10.11.86

# 2. Try to connect to epmd and list nodes
echo "=== Attempting to list nodes via epmd ==="
nc 10.10.11.86 4369 <<< "names"

# 3. Scan for other common Erlang/Elixir ports
echo "=== Scanning for additional Erlang ports ==="
nmap -p 8000-8100,9000-9100,4000-4100 10.10.11.86 --min-rate 1000

# 4. Try common Phoenix/Elixir default ports
echo "=== Testing common Phoenix ports ==="
for port in 4000 4001 4002 8000 8080 3000; do
    echo "Testing port $port..."
    curl -s --max-time 3 http://10.10.11.86:$port/ | head -20
done

# 5. Check if there's a specific endpoint that works
echo "=== Testing specific endpoints ==="
curl -s --max-time 5 http://soulmate.htb/api/health
curl -s --max-time 5 http://soulmate.htb/api/
curl -s --max-time 5 http://soulmate.htb/health
curl -s --max-time 5 http://soulmate.htb/status

