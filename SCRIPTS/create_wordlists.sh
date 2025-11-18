#!/bin/bash
# CREATE SMALL WORDLISTS FOR BRUTE FORCING
# Run this first to create wordlists

WORDLIST_DIR="$HOME/Downloads/wordlists"
mkdir -p "$WORDLIST_DIR"

cd "$WORDLIST_DIR"

echo "Creating wordlists..."

# Common usernames
cat > users_small.txt <<EOF
admin
root
user
test
guest
administrator
sa
sql
www-data
phoenix
xwiki
EOF

# Common passwords
cat > pass_small.txt <<EOF
admin
password
123456
Password123
admin123
P@ssw0rd
Welcome123
Summer2024
Winter2024
Spring2024
Fall2024
EOF

# MSSQL specific usernames
cat > users_mssql.txt <<EOF
sa
admin
administrator
sql
sqladmin
mssql
dbadmin
backup
svc_mssql
MSSQLSvc
SQLSvc
EOF

# MSSQL specific passwords
cat > pass_mssql.txt <<EOF
password
Password123
P@ssw0rd
admin
Admin123
Welcome123
Summer2024
Winter2024
Spring2024
Fall2024
EOF

echo "Wordlists created in: $WORDLIST_DIR"
ls -lh "$WORDLIST_DIR"

