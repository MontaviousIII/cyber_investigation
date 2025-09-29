#!/bin/bash
# Cyber Investigation Training Environment Setup
# Save this as: setup_investigation.sh
# Run with: bash setup_investigation.sh

echo "🔧 Setting up Cyber Investigation Training Environment..."

# Create directory structure
mkdir -p ~/cyber_investigation/{logs,challenges,scripts}
cd ~/cyber_investigation

# Create sample log files
echo "📝 Creating sample log files..."

# 1. Access.log - Web server logs
cat > logs/access.log << 'EOF'
192.168.1.105 - - [2024-01-15 10:15:23] "GET /index.html HTTP/1.1" 200 5234 "-" "Mozilla/5.0"
10.0.0.55 - - [2024-01-15 10:16:45] "GET /admin.php HTTP/1.1" 404 234 "-" "curl/7.68.0"
192.168.1.105 - - [2024-01-15 10:17:12] "GET /products.html HTTP/1.1" 200 8923 "-" "Mozilla/5.0"
10.0.0.55 - - [2024-01-15 10:18:33] "POST /login.php?user=admin' OR '1'='1 HTTP/1.1" 500 0 "-" "python-requests/2.25.1"
172.16.0.12 - - [2024-01-15 10:19:45] "GET /contact.html HTTP/1.1" 200 3421 "-" "Mozilla/5.0"
192.168.1.222 - - [2024-01-15 10:20:11] "GET /../../../../etc/passwd HTTP/1.1" 400 0 "-" "scanner/1.0"
10.0.0.55 - - [2024-01-15 10:21:33] "POST /upload.php HTTP/1.1" 403 0 "-" "wget/1.20.3"
192.168.1.105 - - [2024-01-15 10:22:44] "GET /about.html HTTP/1.1" 200 4532 "-" "Mozilla/5.0"
172.16.0.12 - - [2024-01-15 10:23:55] "GET /admin/ HTTP/1.1" 401 0 "-" "Mozilla/5.0"
10.0.0.55 - - [2024-01-15 10:24:22] "DELETE /api/users/1 HTTP/1.1" 403 0 "-" "curl/7.68.0"
192.168.1.15 - - [2024-01-15 10:25:33] "GET /login.html HTTP/1.1" 200 2341 "-" "Chrome/96.0"
203.0.113.45 - - [2024-01-15 10:26:44] "GET /search?q= HTTP/1.1" 200 5643 "-" "scanner/2.0"
192.168.1.105 - - [2024-01-15 10:27:55] "POST /api/data HTTP/1.1" 201 432 "-" "Mozilla/5.0"
10.0.0.55 - - [2024-01-15 10:28:11] "PUT /api/config HTTP/1.1" 403 0 "-" "python-requests/2.25.1"
172.16.0.99 - - [2024-01-15 10:29:22] "GET /dashboard HTTP/1.1" 404 234 "-" "Mozilla/5.0"
EOF

# 2. Auth.log - Authentication logs
cat > logs/auth.log << 'EOF'
Jan 15 09:45:23 server sshd[1234]: Accepted password for john from 192.168.1.105 port 52341 ssh2
Jan 15 09:46:11 server sshd[1235]: Failed password for root from 10.0.0.55 port 43234 ssh2
Jan 15 09:47:33 server sshd[1236]: Failed password for admin from 10.0.0.55 port 43235 ssh2
Jan 15 09:48:44 server sshd[1237]: Accepted publickey for alice from 192.168.1.15 port 52342 ssh2
Jan 15 09:49:55 server sshd[1238]: Failed password for oracle from 203.0.113.45 port 41234 ssh2
Jan 15 09:50:11 server sshd[1239]: Failed password for postgres from 203.0.113.45 port 41235 ssh2
Jan 15 09:51:22 server sshd[1240]: Failed password for mysql from 10.0.0.55 port 43236 ssh2
Jan 15 09:52:33 server sshd[1241]: Accepted password for bob from 192.168.1.222 port 52343 ssh2
Jan 15 09:53:44 server sshd[1242]: Failed password for test from 10.0.0.55 port 43237 ssh2
Jan 15 09:54:55 server sshd[1243]: Failed password for guest from 203.0.113.45 port 41236 ssh2
Jan 15 09:55:11 server sshd[1244]: Failed password for admin from 192.168.1.99 port 52344 ssh2
Jan 15 09:56:22 server sshd[1245]: Accepted password for john from 192.168.1.105 port 52345 ssh2
Jan 15 09:57:33 server sshd[1246]: Failed password for root from 10.0.0.55 port 43238 ssh2
Jan 15 09:58:44 server sshd[1247]: Failed password for administrator from 10.0.0.55 port 43239 ssh2
Jan 15 09:59:55 server sshd[1248]: Accepted password for alice from 192.168.1.15 port 52346 ssh2
EOF

# 3. Application.log - Application logs with various error levels
cat > logs/application.log << 'EOF'
2024-01-15 10:00:00 INFO Application started successfully
2024-01-15 10:01:23 DEBUG Connecting to database server at 192.168.1.50
2024-01-15 10:02:34 INFO User john logged in from 192.168.1.105
2024-01-15 10:03:45 ERROR Database connection failed: Connection refused
2024-01-15 10:04:56 WARN Memory usage at 85%
2024-01-15 10:05:12 INFO Processing request from 172.16.0.12
2024-01-15 10:06:23 ERROR [ERROR] Connection refused to payment gateway
2024-01-15 10:07:34 FATAL System critical error: Disk full
2024-01-15 10:08:45 INFO User alice logged in from 192.168.1.15
2024-01-15 10:09:56 ERROR Invalid API key provided by 10.0.0.55
2024-01-15 10:10:12 WARN Suspicious activity detected from 203.0.113.45
2024-01-15 10:11:23 INFO Data export completed successfully
2024-01-15 10:12:34 ERROR [ERROR] Connection refused to cache server
2024-01-15 10:13:45 WARN CPU usage at 90%
2024-01-15 10:14:56 INFO User bob logged out
EOF

# 4. Suspicious.txt - File with potential malware indicators
cat > logs/suspicious.txt << 'EOF'
Normal text content here
Found encoded string: dGhpcyBpcyBhIHRlc3QgbWVzc2FnZQ==
Another line of normal content
Potential payload: cG93ZXJzaGVsbCAtZSBieXBhc3M=
Regular application data
Base64 pattern: YWRtaW46cGFzc3dvcmQxMjM=
System configuration line
Encoded data: ZXZpbCBzY3JpcHQgY29udGVudA==
More normal text
Hidden string: c2VjcmV0IGluZm9ybWF0aW9u
EOF

# 5. Network.log - Network connection logs
cat > logs/network.log << 'EOF'
2024-01-15 10:00:00 Connection established: 192.168.1.105:54234 -> 93.184.216.34:443
2024-01-15 10:01:15 Connection established: 10.0.0.55:43234 -> 192.168.1.1:22
2024-01-15 10:02:30 Connection dropped: 172.16.0.12:52345 -> 8.8.8.8:53
2024-01-15 10:03:45 Connection established: 192.168.1.222:54235 -> 192.168.1.50:3306
2024-01-15 10:05:00 Suspicious scan detected from 203.0.113.45
2024-01-15 10:06:15 Connection established: 192.168.1.15:54236 -> 172.217.16.142:443
2024-01-15 10:07:30 Port scan detected: 10.0.0.55 -> 192.168.1.1:1-65535
2024-01-15 10:08:45 Connection established: 192.168.1.105:54237 -> 192.168.1.50:5432
2024-01-15 10:10:00 Connection timeout: 172.16.0.99:52346 -> 10.10.10.10:80
2024-01-15 10:11:15 Connection established: 192.168.1.15:54238 -> 52.84.228.25:443
EOF

echo "✅ Log files created successfully!"
