# Cyber Investigation Practice Lab

A comprehensive command-line forensics training environment for mastering network and log analysis skills for cybersecurity interviews and incident response scenarios.

## Overview

This repository contains realistic log files and 20 progressive challenges simulating real-world cybersecurity investigations. Practice grep, regex patterns, and shell pipelines in a safe, controlled environment.

**Key Features:**
- 20 progressive challenges (basic to advanced)
- 794+ realistic log entries across 5 files
- War-game style training (no answers shown, retry until correct)
- Dynamic answer validation
- Hints mode for learning, Expert mode for testing

## Quick Start

```bash
# Navigate to logs directory
cd ~/cyber_investigation/logs

# Explore log files
ls -lh
less access.log         # Web server logs (164 entries)
less auth.log           # SSH authentication (192 entries)
less application.log    # Application errors (188 entries)
less network.log        # Network traffic (128 entries)
less suspicious.txt     # Suspicious patterns (122 entries)

# Practice commands
grep -F "192.168.1.105" access.log
grep -P "Failed password" auth.log | wc -l
grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' access.log | sort -u

# Start challenges
bash ~/cyber_investigation/challenges/start.sh

# View solutions (if stuck)
bash ~/cyber_investigation/challenges/solutions.sh
```

## Repository Structure

```
cyber_investigation/
├── README.md                   # This file
├── logs/                       # Training log files
│   ├── access.log             # HTTP access logs (164 entries)
│   ├── auth.log               # SSH authentication (192 entries)
│   ├── application.log        # Application logs (188 entries)
│   ├── network.log            # Network traffic (128 entries)
│   └── suspicious.txt         # Suspicious patterns (122 entries)
└── challenges/                 # Challenge system
    ├── start.sh               # Interactive challenge runner
    └── solutions.sh           # Complete answer key
```

## Challenge Breakdown

### Level 1: Basic Grep (Challenges 1-2)
**Skills:** Fixed string search with `-F` flag
- Finding specific IP addresses
- Counting failed authentication attempts

### Level 2: Regex Pattern Matching (Challenges 3-4)
**Skills:** Perl regex with `-P` flag, multiple patterns
- Extracting and counting unique IPs
- Multi-pattern searches (ERROR|FATAL)

### Level 3: Pipeline Mastery (Challenges 5-6)
**Skills:** Complex command pipelines
- Identifying most active IPs
- Detecting suspicious user agents

### Level 4: Security Investigation (Challenges 7-10)
**Skills:** Security-focused analysis
- SQL injection detection
- Base64 encoded payload discovery
- HTTP method analysis
- User behavior analytics

### Level 5: Advanced Regex Mastery (Challenges 11-20)
**Skills:** Complex regex patterns and data extraction
- Email domain extraction
- Phone number format recognition
- IPv6 address identification
- JWT token detection
- Cryptographic hash matching (MD5, SHA256)
- Service name extraction using lookbehind/lookahead
- TLS version analysis
- Time-based log filtering
- MAC address extraction
- HTTP status code analysis

## Challenge Quick Reference

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
grep -oP '(\b([0-9a-fA-F]{4}:){7}[0-9a-fA-F]{4}\b|\b[0-9a-fA-F]{4}::[0-9a-fA-F]{1,4}\b)' suspicious.txt | wc -l

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

## Essential Grep Flags

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

## Common Regex Patterns

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

## Pipeline Patterns

```bash
# Count and rank
... | sort | uniq -c | sort -rn

# Unique only
... | sort -u

# Top N
... | head -N

# Extract field
... | awk '{print $N}'

# Chain filters
grep X | grep -v Y | grep Z
```

## Real-World Examples

```bash
# Top 5 IPs by request count
grep -oP '\d+\.\d+\.\d+\.\d+' access.log | sort | uniq -c | sort -rn | head -5

# All errors from specific time range
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
```

## Interview Prep Checklist

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

## War-Game Style Challenge System

The challenge system simulates incident response pressure:

**Features:**
- Get it wrong? Screen clears and question repeats
- No answers shown - figure it out yourself
- Keep trying until you get it right
- Type `skip` if you need to move on
- Clean screen on every question
- Dynamic answer validation (commands run live)

**Example Flow:**
```
Challenge 1: Count lines containing IP 192.168.1.105 in access.log

Hint: Try this command: grep -F '192.168.1.105' access.log | wc -l

Enter your answer (or 'skip' to skip): 3

INCORRECT - Try again
[Screen clears and question repeats]
```

## Scoring System

- **20/20**: Perfect score - Interview ready
- **16-19**: Great job - Practice missed challenges
- **12-15**: Good progress - Review grep flags and pipelines
- **0-11**: Keep practicing - Review the basics

## Advanced Regex Techniques

- **Lookahead/Lookbehind**: `\K` to extract portions after match
- **Character Classes**: `[a-zA-Z0-9._%+-]+` for email validation
- **Quantifiers**: `{2,7}` for flexible matching
- **Alternation**: `(ERROR|FATAL|CRITICAL)` for multi-pattern
- **Word Boundaries**: `\b` for precise hash matching
- **Non-capturing Groups**: `(?:...)` for grouping without capture

## Learning Path

**Beginner (Challenges 1-6):** Focus on basic grep usage and simple patterns. Learn `-F` for literal strings and `-P` for basic regex. Practice counting and filtering.

**Intermediate (Challenges 7-10):** Apply grep to security scenarios. Learn to identify attack patterns like SQL injection, suspicious user agents, and non-standard HTTP methods.

**Advanced (Challenges 11-20):** Master complex regex patterns. Extract structured data (emails, IPs, hashes), perform time-based analysis, and use advanced assertions.

## Pro Tips

1. **Test incrementally**: Build pipelines one step at a time
2. **Use less**: Pipe to `| less` to browse long output
3. **Quote regex**: Use single quotes to avoid shell interpretation
4. **Debug with -o**: Use `-o` to see exactly what matched
5. **Count first**: Use `wc -l` to verify before processing large datasets
6. **Time commands**: Prefix with `time` to measure performance

## Common Mistakes

```bash
# Wrong: Forgets to escape dots
grep -P '10.0.0.55' file.log    # Matches 10X0X0X55

# Right: Escapes special characters
grep -P '10\.0\.0\.55' file.log

# Wrong: Double escaping in scripts
echo "grep -P '\\d+' file"      # Prints grep -P '\d+'

# Right: Single escape in command line
grep -P '\d+' file.log
```

## Statistics

| Metric | Value |
|--------|-------|
| Total Challenges | 20 |
| Total Log Entries | 794+ |
| Log Files | 5 |
| Regex Patterns Covered | 20+ |
| Attack Types Simulated | 30+ |

## Skills You'll Master

1. Fixed string searches with `-F`
2. Perl regex patterns with `-P`
3. Output extraction with `-o`
4. Complex pipelines with `sort | uniq -c | sort -rn`
5. Field extraction with `awk`
6. Pattern inversion with `-v`
7. Case-insensitive matching with `-i`
8. Lookahead and lookbehind assertions
9. Character class construction
10. Quantifier usage
11. Alternation and grouping
12. Time-based log filtering
13. Attack pattern recognition
14. Data extraction and validation
15. Multi-stage data processing

## Additional Resources

- `man grep` - Full grep manual
- `grep --help` - Quick reference
- `man regex` - Regex syntax
- regex101.com - Test patterns online (use PCRE/PHP flavor for `-P`)
- regexone.com - Different syntax but same foundations
- cmdchallenge.com - Similar to this, more basic challenges

## Notes

- All IP addresses use RFC 5737 documentation ranges (safe, non-routable)
- Log entries simulate realistic attack patterns for educational purposes
- No actual malicious code or credentials included
- Designed for offline practice - no network access required

## Next Steps

1. Run the challenges: `bash ~/cyber_investigation/challenges/start.sh`
2. Complete all 20 challenges in Expert Mode
3. Practice without looking at solutions
4. Time yourself - Can you complete all in under 30 minutes?
5. Create your own challenges by adding patterns to the logs
6. Interview with confidence

---

Remember: The goal isn't just to find the answer, but to understand the command and be able to explain it during an interview.
