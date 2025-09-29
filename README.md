# Cyber Investigation Practice Lab

A comprehensive command-line forensics training environment designed to help you master network and log analysis skills for cybersecurity interviews and incident response scenarios.

## 📋 Overview

This repository contains realistic log files and progressive challenges that simulate real-world cybersecurity investigations. Practice grep, regex patterns, and shell pipelines in a safe, controlled environment.

## 🎯 What You'll Learn

- **grep mastery**: `-F` (fixed strings), `-P` (Perl regex), `-o` (extract), `-v` (invert), `-i` (case-insensitive)
- **Advanced regex patterns**: Email extraction, IP address matching, hash detection, JWT tokens, and more
- **Shell pipelines**: Combining commands with `|`, using `sort`, `uniq`, `wc`, `awk`, `head`, `tail`
- **Log analysis**: HTTP access logs, SSH authentication logs, application logs, network traffic
- **Security pattern recognition**: SQL injection, XSS, path traversal, brute force attacks, encoded payloads

## 🚀 Quick Start

### 1. Navigate to the logs directory
```bash
cd ~/cyber_investigation/logs
```

### 2. Explore the log files
```bash
ls -lh                  # See available log files
less access.log         # Browse web server logs
less auth.log           # Review authentication attempts
less application.log    # Check application errors
less network.log        # Analyze network traffic
less suspicious.txt     # Examine suspicious patterns
```

### 3. Practice freely
Try commands on your own:
```bash
grep -F "192.168.1.105" access.log
grep -P "Failed password" auth.log | wc -l
grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' access.log | sort -u
```

### 4. Take the challenge
```bash
bash ~/cyber_investigation/scripts/verify.sh
```

Choose between:
- **Hints mode** (Recommended for first attempt) - Shows commands to guide you
- **Expert mode** - Test your knowledge without hints

### 5. Check answers (if stuck)
```bash
bash ~/cyber_investigation/scripts/answers.sh
```

## 📊 Challenge Breakdown

### Level 1: Basic Grep Challenges (1-2)
**Skills**: Fixed string search with `-F` flag
- Finding specific IP addresses
- Counting failed authentication attempts
- Real-world application: Quickly locating specific indicators in logs

### Level 2: Regex Pattern Matching (3-4)
**Skills**: Perl regex with `-P` flag, multiple patterns
- Extracting and counting unique IPs
- Multi-pattern searches (ERROR|FATAL)
- Real-world application: Pattern-based threat hunting

### Level 3: Pipeline Mastery (5-6)
**Skills**: Complex command pipelines
- Identifying most active IPs
- Detecting suspicious user agents
- Real-world application: Aggregating and ranking security events

### Level 4: Security Investigation (7-10)
**Skills**: Security-focused analysis
- SQL injection detection
- Base64 encoded payload discovery
- HTTP method analysis
- User behavior analytics
- Real-world application: Incident response and attack detection

### Level 5: Advanced Regex Mastery (11-20)
**Skills**: Complex regex patterns and data extraction
- Email domain extraction and validation
- Phone number format recognition
- IPv6 address identification
- JWT token detection
- Cryptographic hash matching (MD5, SHA256)
- Network attack taxonomy
- TLS version analysis
- Time-based log filtering
- MAC address extraction
- HTTP status code analysis
- Real-world application: Advanced threat intelligence and forensic analysis

## 📁 Repository Structure

```
cyber_investigation/
├── README.md                   # This file
├── logs/                       # Training log files
│   ├── access.log             # HTTP access logs (62+ entries)
│   ├── auth.log               # SSH authentication logs (68+ entries)
│   ├── application.log        # Application logs (70+ entries)
│   ├── network.log            # Network traffic logs (62+ entries)
│   └── suspicious.txt         # Suspicious patterns (54+ entries)
├── scripts/
│   ├── verify.sh              # Interactive challenge verifier
│   └── answers.sh             # Answer key with commands
└── challenges/                 # (Reserved for future challenges)
```

## 💡 Pro Tips for Interview Success

### Essential Commands
```bash
# Count lines
wc -l file.log

# Fixed string search (faster, literal)
grep -F "exact string" file.log

# Perl regex search (powerful patterns)
grep -P "regex pattern" file.log

# Extract only matching parts
grep -oP '\d+\.\d+\.\d+\.\d+' file.log

# Case-insensitive search
grep -i "error" file.log

# Invert match (exclude)
grep -v "DEBUG" file.log
```

### Pipeline Patterns
```bash
# Count occurrences and sort by frequency
grep pattern file.log | sort | uniq -c | sort -rn

# Get unique values only
grep pattern file.log | sort -u

# Extract specific field with awk
grep pattern file.log | awk '{print $5}'

# Limit output to top N results
grep pattern file.log | sort | uniq -c | sort -rn | head -10

# Chain multiple greps for precision
grep "ERROR" file.log | grep -v "timeout" | grep "database"
```

### Regex Cheat Sheet
```bash
# IP address (basic)
\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}

# Email address
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}

# Phone number (various formats)
(\+\d{1,2}[- ])?\(?\d{3}\)?[- .]?\d{3}[- .]?\d{4}

# Hexadecimal (MAC, hashes)
[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:...  # MAC address
\b[a-f0-9]{32}\b                    # MD5 hash
\b[a-f0-9]{64}\b                    # SHA256 hash

# JWT token
eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+

# Time ranges
10:5[0-9]:                          # 10:50-10:59
11:0[0-9]:                          # 11:00-11:09

# Alternation (OR)
(ERROR|FATAL|CRITICAL)              # Match any
(POST|PUT|DELETE|PATCH)             # HTTP methods
```

## 🎓 Learning Path

### Beginner (Challenges 1-6)
Focus on basic grep usage and simple patterns. Learn to use `-F` for literal strings and `-P` for basic regex. Practice counting and filtering.

### Intermediate (Challenges 7-10)
Apply grep to security scenarios. Learn to identify attack patterns like SQL injection, suspicious user agents, and non-standard HTTP methods.

### Advanced (Challenges 11-20)
Master complex regex patterns. Extract structured data (emails, IPs, hashes), perform time-based analysis, and recognize attack taxonomies.

## 🔍 Common Interview Questions

This lab prepares you for questions like:

1. **"Show me all failed login attempts from a specific IP"**
   ```bash
   grep "Failed password" auth.log | grep "10.0.0.55"
   ```

2. **"What are the top 5 most active IP addresses?"**
   ```bash
   grep -oP '\d+\.\d+\.\d+\.\d+' access.log | sort | uniq -c | sort -rn | head -5
   ```

3. **"Find all POST requests that returned 500 errors"**
   ```bash
   grep "POST" access.log | grep "\" 500"
   ```

4. **"Extract all unique user agents accessing /admin"**
   ```bash
   grep "/admin" access.log | grep -oP '"[^"]+"\s*$' | sort -u
   ```

5. **"How many unique users successfully logged in?"**
   ```bash
   grep "Accepted" auth.log | grep -oP 'for \K\w+' | sort -u | wc -l
   ```

## 🏆 Scoring System

- **20/20**: Perfect score - Interview ready!
- **16-19**: Great job - Practice missed challenges
- **12-15**: Good progress - Review grep flags and pipelines
- **0-11**: Keep practicing - Review the basics

## 🛠️ Advanced Usage

### Create custom challenges
Add your own log entries to the files in `logs/` directory.

### Test specific skills
```bash
# Practice only IP extraction
grep -oP '\d+\.\d+\.\d+\.\d+' logs/*.log | less

# Practice only error detection
grep -P '(ERROR|FATAL|CRITICAL)' logs/*.log | less

# Practice time-based filtering
grep -P '10:[3-5][0-9]:' logs/application.log
```

### Pipeline debugging
```bash
# Test each step of a pipeline individually
grep "pattern" file.log                          # Step 1
grep "pattern" file.log | sort                   # Step 2
grep "pattern" file.log | sort | uniq -c         # Step 3
grep "pattern" file.log | sort | uniq -c | sort -rn  # Step 4
```

## 📚 Additional Resources

### Grep Documentation
- `man grep` - Full grep manual
- `grep --help` - Quick reference

### Regex Testing
- [regex101.com](https://regex101.com) - Test patterns online (use PCRE/PHP flavor for `-P`)
- [regexr.com](https://regexr.com) - Interactive regex learning

### Practice Files
All log files contain realistic data patterns you'll encounter in production environments:
- Web server access logs (Apache/Nginx format)
- SSH authentication logs (syslog format)
- Structured application logs (timestamp, level, message)
- Network connection logs
- Suspicious activity indicators

## 🤝 Contributing

Found a bug or want to add more challenges? Feel free to:
1. Add more log entries to increase difficulty
2. Create additional challenge scenarios
3. Improve documentation

## 📝 Notes

- All IP addresses use RFC 5737 documentation ranges (safe, non-routable)
- Log entries simulate realistic attack patterns for educational purposes
- No actual malicious code or credentials are included
- Designed for offline practice - no network access required

## 🎯 Next Steps

1. **Complete all 20 challenges in Expert Mode**
2. **Practice without looking at answers**
3. **Time yourself** - Can you complete all challenges in under 30 minutes?
4. **Create your own challenges** by adding complex patterns to the logs
5. **Interview with confidence!**

---

**Good luck with your interview preparation! 🚀**

*Remember: The goal isn't just to find the answer, but to understand the command and be able to explain it during an interview.*