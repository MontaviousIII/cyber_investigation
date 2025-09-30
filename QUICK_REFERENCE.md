# Quick Reference Guide

## 🚀 Getting Started (30 seconds)

```bash
cd ~/cyber_investigation/logs
bash ~/cyber_investigation/challenges/start.sh
```

## 📝 Challenge Quick Answers

### Level 1: Basic Grep (1-2)
```bash
# 1. Count specific IP
grep -F '192.168.1.105' access.log | wc -l

# 2. Failed SSH attempts
grep 'Failed password' auth.log | wc -l
```

### Level 2: Regex Patterns (3-4)
```bash
# 3. Unique IPs
grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' access.log | sort -u | wc -l

# 4. ERROR or FATAL
grep -P 'ERROR|FATAL' application.log | wc -l
```

### Level 3: Pipelines (5-6)
```bash
# 5. Most active IP
grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' access.log | sort | uniq -c | sort -rn | head -1 | awk '{print $2}'

# 6. Suspicious user agents
grep -P 'curl|wget|python|scanner' access.log | wc -l
```

### Level 4: Security Analysis (7-10)
```bash
# 7. SQL injection attempts
grep -P "(--|'|union|select)" access.log | wc -l

# 8. Base64 strings
grep -P '[A-Za-z0-9+/]{20,}={0,2}' suspicious.txt | wc -l

# 9. Most frequent login user
grep 'Accepted' auth.log | grep -oP 'for \K\w+' | sort | uniq -c | sort -rn | head -1 | awk '{print $2}'

# 10. Non-GET HTTP methods
grep -P '(POST|PUT|DELETE)' access.log | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | wc -l
```

### Level 5: Advanced Regex (11-20)
```bash
# 11. Email domains
grep -oP '[a-zA-Z0-9._%+-]+@\K[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' suspicious.txt | sort -u | wc -l

# 12. Phone numbers
grep -P '(\+\d{1,2}[- ])?\(?\d{3}\)?[- .]?\d{3}[- .]?\d{4}' suspicious.txt | wc -l

# 13. IPv6 addresses
grep -P '([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}' suspicious.txt | wc -l

# 14. JWT tokens
grep -P 'eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+' suspicious.txt | wc -l

# 15. MD5 or SHA256 hashes
grep -P '\b[a-f0-9]{32}\b|\b[a-f0-9]{64}\b' suspicious.txt | wc -l

# 16. Service names in parentheses
grep -oP '\(\K[A-Z][a-z]+(?=\)$)' network.log | sort -u | wc -l

# 17. TLS 1.2 or 1.3
grep -P 'TLS1\.(2|3)' network.log | wc -l

# 18. Time range 10:50-11:10
grep -P '(10:5[0-9]|11:0[0-9]|11:10):' application.log | wc -l

# 19. Unique MAC addresses
grep -oP '([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}' suspicious.txt | sort -u | wc -l

# 20. Most common HTTP status
grep -oP 'HTTP/\d\.\d" \K\d{3}' access.log | sort | uniq -c | sort -rn | head -1 | awk '{print $2}'
```

## 🎯 Essential Grep Flags

```bash
-F    # Fixed string (literal, fastest)
-P    # Perl regex (most powerful)
-o    # Output only matching part
-v    # Invert match (exclude)
-i    # Case insensitive
-c    # Count matches
-n    # Show line numbers
-A N  # Show N lines after match
-B N  # Show N lines before match
-C N  # Show N lines before and after
```

## 🔥 Common Regex Patterns

```bash
\d              # Any digit [0-9]
\w              # Any word character [a-zA-Z0-9_]
\s              # Any whitespace
.               # Any character
^               # Start of line
$               # End of line
\b              # Word boundary
\K              # Keep left, return right (lookbehind alternative)
*               # 0 or more
+               # 1 or more
?               # 0 or 1 (optional)
{n}             # Exactly n
{n,}            # n or more
{n,m}           # Between n and m
[abc]           # Character class (a, b, or c)
[^abc]          # Negated class (not a, b, or c)
(a|b)           # Alternation (a or b)
```

## 💪 Pipeline Patterns

```bash
# Count and rank
... | sort | uniq -c | sort -rn

# Unique only
... | sort -u

# Top N
... | head -N

# Bottom N
... | tail -N

# Extract field
... | awk '{print $N}'

# Sum numbers
... | awk '{sum+=$1} END {print sum}'

# Chain filters
grep X | grep -v Y | grep Z
```

## 📊 Real-World Examples

```bash
# Top 5 IPs by request count
grep -oP '\d+\.\d+\.\d+\.\d+' access.log | sort | uniq -c | sort -rn | head -5

# All errors from last hour
grep -P '11:[0-5][0-9]:' application.log | grep ERROR

# Users who ran sudo
grep sudo auth.log | grep -oP 'USER=root ; COMMAND=/\K.*' | sort -u

# Attack IPs (multiple failed attempts)
grep "Failed password" auth.log | grep -oP 'from \K\S+' | sort | uniq -c | sort -rn

# Files accessed by scanning tools
grep -P 'nikto|sqlmap|nmap|masscan' access.log | grep -oP '"[A-Z]+ \K[^"?]+' | sort -u

# Successful vs failed login ratio
echo "Success: $(grep -c 'Accepted' auth.log)"
echo "Failed: $(grep -c 'Failed password' auth.log)"

# Extract all sensitive file access attempts
grep -P '\.\.(\/|\\)' access.log | grep -oP '"[A-Z]+ \K[^"]+' | sort -u
```

## 🎓 Pro Tips

1. **Test incrementally**: Build pipelines one step at a time
2. **Use less**: Pipe to `| less` to browse long output
3. **Quote regex**: Use single quotes to avoid shell interpretation
4. **Escape in grep -P**: Use `\d` not `\\d` in command line
5. **Debug with -o**: Use `-o` to see exactly what matched
6. **Count first**: Use `wc -l` to verify before processing large datasets
7. **Time commands**: Prefix with `time` to measure performance

## ⚠️ Common Mistakes

```bash
# ❌ Wrong: Forgets to escape dots
grep -P '10.0.0.55' file.log    # Matches 10X0X0X55

# ✅ Right: Escapes special characters
grep -P '10\.0\.0\.55' file.log

# ❌ Wrong: Double escaping in scripts
echo "grep -P '\\d+' file"      # Prints grep -P '\d+'

# ✅ Right: Single escape in command line
grep -P '\d+' file.log

# ❌ Wrong: Quotes allow shell expansion
grep "user=$USER" file.log      # Expands $USER

# ✅ Right: Single quotes prevent expansion
grep 'user=$USER' file.log
```

## 📱 One-Liners for Common Tasks

```bash
# Show connection pairs
grep "established" network.log | grep -oP '\d+\.\d+\.\d+\.\d+:\d+ -> \d+\.\d+\.\d+\.\d+:\d+'

# Count errors by type
grep ERROR application.log | grep -oP '\[.*?\]' | sort | uniq -c | sort -rn

# Find time gaps (lines with no activity)
grep -P '10:(0[0-9]|1[0-9]|2[0-9]):[0-9]{2}' application.log | wc -l

# Extract all admin actions
grep -P '/admin|role=admin' access.log | grep -oP '\d+\.\d+\.\d+\.\d+' | sort -u

# Identify brute force sources
grep "Failed password" auth.log | grep -oP 'from \K[\d.]+' | sort | uniq -c | awk '$1 >= 5'
```

## 🎯 Interview Prep Checklist

- [ ] Can explain what `-F`, `-P`, and `-o` do
- [ ] Can write IP address regex from memory
- [ ] Can build `sort | uniq -c | sort -rn` pipeline
- [ ] Can extract specific fields with `awk`
- [ ] Can use lookahead/lookbehind (`\K`)
- [ ] Can chain multiple grep commands
- [ ] Can explain when to use `-F` vs `-P`
- [ ] Can read and explain others' grep commands
- [ ] Can debug failed regex patterns
- [ ] Can optimize slow grep commands

## 📞 Need Help?

```bash
man grep              # Full documentation
grep --help           # Quick help
man regex             # Regex syntax
```

---

**Pro tip**: Print this page and keep it next to you during practice! 🎯