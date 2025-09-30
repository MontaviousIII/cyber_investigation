#!/bin/bash
# Interactive challenge system with optional hints
# Location: ~/cyber_investigation/challenges/start.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Change to logs directory
cd ~/cyber_investigation/logs

clear
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}    🔍 CYBER INVESTIGATION CHALLENGE SYSTEM 🔍${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

# Ask about hints
echo -e "${CYAN}Would you like hints for each challenge?${NC}"
echo -e "${CYAN}Hints will show the command to try.${NC}"
echo -e "${CYAN}Choose your difficulty level:${NC}\n"
echo -e "  ${GREEN}1)${NC} Show hints (Recommended for first attempt)"
echo -e "  ${YELLOW}2)${NC} No hints (Test your knowledge)"
echo ""
read -p "Enter your choice (1 or 2): " hint_choice

# Set hints flag
if [ "$hint_choice" == "1" ]; then
    SHOW_HINTS=true
    echo -e "\n${GREEN}✓ Hints enabled - Commands will be shown${NC}\n"
else
    SHOW_HINTS=false
    echo -e "\n${YELLOW}⚡ Expert mode - No hints!${NC}\n"
fi

echo -e "Press Enter to begin..."
read

clear

# Function to prompt and validate answer with retry loop
prompt_and_check() {
    local challenge_num=$1
    local question="$2"
    local description="$3"
    local hint_command="$4"

    # Dynamically calculate the expected answer by running the command
    local expected=$(eval "$hint_command" 2>/dev/null)

    while true; do
        clear
        echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
        echo -e "${YELLOW}Challenge $challenge_num: $question${NC}"
        echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

        if [ "$SHOW_HINTS" == true ] && [ ! -z "$hint_command" ]; then
            echo -e "${CYAN}Hint: Try this command: ${hint_command}${NC}\n"
        fi

        read -p "Enter your answer (or 'skip' to skip): " user_answer

        # Check if user wants to skip
        if [ "$user_answer" == "skip" ]; then
            echo -e "\n${YELLOW}⏭️  SKIPPED${NC}"
            sleep 1
            return 0
        fi

        # Check if answer is correct
        if [ "$user_answer" == "$expected" ]; then
            echo -e "\n${GREEN}✅ CORRECT!${NC}"
            sleep 1
            return 1
        else
            echo -e "\n${RED}❌ INCORRECT - Try again${NC}"
            sleep 1.5
        fi
    done
}

score=0
total=20

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}LEVEL 1: BASIC GREP CHALLENGES${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

# Challenge 1
prompt_and_check 1 "Count lines containing IP 192.168.1.105 in access.log" "Fixed string search for IP" "grep -F '192.168.1.105' access.log | wc -l"
score=$((score + $?))

# Challenge 2
prompt_and_check 2 "How many failed SSH attempts are in auth.log?" "Counting failed authentication attempts" "grep 'Failed password' auth.log | wc -l"
score=$((score + $?))

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}LEVEL 2: REGEX PATTERN MATCHING${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

# Challenge 3
prompt_and_check 3 "Count unique IP addresses in access.log" "Extract and count unique IPs with regex" "grep -oP '\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}' access.log | sort -u | wc -l"
score=$((score + $?))

# Challenge 4
prompt_and_check 4 "How many ERROR or FATAL messages in application.log?" "Multiple pattern matching" "grep -P 'ERROR|FATAL' application.log | wc -l"
score=$((score + $?))

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}LEVEL 3: PIPELINE MASTERY${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

# Challenge 5
prompt_and_check 5 "Find the attacker IP that made the most requests in access.log" "Identify most active IP" "grep -oP '\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}' access.log | sort | uniq -c | sort -rn | head -1 | awk '{print \$2}'"
score=$((score + $?))

# Challenge 6
prompt_and_check 6 "Count suspicious user agents (curl, wget, python, scanner) in access.log" "Detect suspicious user agents" "grep -P 'curl|wget|python|scanner' access.log | wc -l"
score=$((score + $?))

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}LEVEL 4: SECURITY INVESTIGATION${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

# Challenge 7
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Look for SQL keywords or special characters used in injections${NC}"
fi
prompt_and_check 7 "How many potential SQL injection attempts in access.log?" "Detect SQL injection patterns" "grep -P \"(--|'|union|select)\" access.log | wc -l"
score=$((score + $?))

# Challenge 8
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Base64 strings contain A-Z, a-z, 0-9, +, / and end with = padding${NC}"
fi
prompt_and_check 8 "Count base64 encoded strings in suspicious.txt" "Find base64 encoded data" "grep -P '[A-Za-z0-9+/]{20,}={0,2}' suspicious.txt | wc -l"
score=$((score + $?))

# Challenge 9
prompt_and_check 9 "Which user successfully logged in the most in auth.log?" "Identify most frequent successful login" "grep 'Accepted' auth.log | grep -oP 'for \\K\\w+' | sort | uniq -c | sort -rn | head -1 | awk '{print \$2}'"
score=$((score + $?))

# Challenge 10
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Look for POST, PUT, DELETE methods${NC}"
fi
prompt_and_check 10 "Count unique IPs attempting HTTP methods other than GET in access.log" "Detect non-GET HTTP methods" "grep -P '(POST|PUT|DELETE)' access.log | grep -oP '\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}' | sort -u | wc -l"
score=$((score + $?))

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}LEVEL 5: ADVANCED REGEX MASTERY${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

# Challenge 11
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Match email pattern, extract domain after @, count unique${NC}"
fi
prompt_and_check 11 "Extract all email addresses from suspicious.txt and count unique domains" "Extract and count unique email domains" "grep -oP '[a-zA-Z0-9._%+-]+@\\K[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}' suspicious.txt | sort -u | wc -l"
score=$((score + $?))

# Challenge 12
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Match patterns like +1-555-0123, (555) 456-7890, 555.234.5678${NC}"
fi
prompt_and_check 12 "How many lines contain phone numbers in any format in suspicious.txt?" "Match various phone number formats" "grep -P '(\\+\\d{1,2}[- ])?\\(?(\\d{3})\\)?[- .]?(\\d{3})[- .]?(\\d{4})' suspicious.txt | wc -l"
score=$((score + $?))

# Challenge 13
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}IPv6 has format like 2001:0db8:85a3::8a2e:0370:7334${NC}"
fi
prompt_and_check 13 "Count IPv6 addresses in suspicious.txt" "Detect IPv6 address patterns" "grep -oP '(\\b([0-9a-fA-F]{4}:){7}[0-9a-fA-F]{4}\\b|\\b[0-9a-fA-F]{4}::[0-9a-fA-F]{1,4}\\b)' suspicious.txt | wc -l"
score=$((score + $?))

# Challenge 14
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}JWT tokens start with eyJ and contain base64-like characters${NC}"
fi
prompt_and_check 14 "Find lines containing JWT tokens (starting with eyJ) in suspicious.txt" "Match JWT token pattern" "grep -P 'eyJ[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]+' suspicious.txt | wc -l"
score=$((score + $?))

# Challenge 15
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}MD5 is 32 hex chars, SHA256 is 64 hex chars${NC}"
fi
prompt_and_check 15 "Count lines in suspicious.txt with MD5 or SHA256 hashes" "Match cryptographic hash patterns" "grep -P '\\b[a-f0-9]{32}\\b|\\b[a-f0-9]{64}\\b' suspicious.txt | wc -l"
score=$((score + $?))

# Challenge 16
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Use lookbehind \\K and lookahead (?=) to extract service names${NC}"
fi
prompt_and_check 16 "Count unique service names in parentheses at end of lines in network.log" "Extract service names using Perl regex assertions" "grep -oP '\\(\\K[A-Z][a-z]+(?=\\)\$)' network.log | sort -u | wc -l"
score=$((score + $?))

# Challenge 17
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Match TLS1.2 or TLS1.3 in the log entries${NC}"
fi
prompt_and_check 17 "Count connections in network.log using TLS version 1.2 or 1.3" "Match specific TLS versions" "grep -P 'TLS1\\.(2|3)' network.log | wc -l"
score=$((score + $?))

# Challenge 18
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Match time pattern HH:MM where hour is 10 (minutes 50-59) or 11 (minutes 00-10)${NC}"
fi
prompt_and_check 18 "Find all lines in application.log with timestamps between 10:50 and 11:10" "Match time range with regex" "grep -P '(10:5[0-9]|11:0[0-9]|11:10):' application.log | wc -l"
score=$((score + $?))

# Challenge 19
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}MAC format: XX:XX:XX:XX:XX:XX or XX-XX-XX-XX-XX-XX${NC}"
fi
prompt_and_check 19 "Count unique MAC addresses in suspicious.txt" "Extract and count unique MAC addresses" "grep -oP '([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}' suspicious.txt | sort -u | wc -l"
score=$((score + $?))

# Challenge 20
if [ "$SHOW_HINTS" == true ]; then
    echo -e "${CYAN}Status codes are 3-digit numbers after the HTTP version${NC}"
fi
prompt_and_check 20 "Find the most common HTTP status code in access.log" "Extract and find most frequent status code" "grep -oP 'HTTP/\\d\\.\\d\" \\K\\d{3}' access.log | sort | uniq -c | sort -rn | head -1 | awk '{print \$2}'"
score=$((score + $?))

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}                    FINAL SCORE                              ${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"

if [ $score -eq $total ]; then
    echo -e "${GREEN}🎉 PERFECT SCORE! $score/$total - You're ready for the interview!${NC}"
    if [ "$SHOW_HINTS" == false ]; then
        echo -e "${GREEN}🏆 ACHIEVEMENT: Perfect score in EXPERT MODE! Outstanding!${NC}"
    fi
elif [ $score -ge 16 ]; then
    echo -e "${GREEN}Great job! $score/$total - Almost there, practice the missed ones.${NC}"
elif [ $score -ge 12 ]; then
    echo -e "${YELLOW}Good progress! $score/$total - Review grep flags and pipelines.${NC}"
else
    echo -e "${RED}Keep practicing! $score/$total - Review the basics and try again.${NC}"
fi

echo -e "\n${BLUE}COMMAND REFERENCE:${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}Essential grep flags:${NC}"
echo "  -F : Fixed string (literal, no regex)"
echo "  -P : Perl regex (advanced patterns)"
echo "  -o : Output only matching part"
echo "  -c : Count matching lines"
echo ""
echo -e "${GREEN}Key pipeline components:${NC}"
echo "  sort | uniq -c | sort -rn : Count occurrences"
echo "  sort -u : Get unique values"
echo "  awk '{print \$N}' : Extract Nth field"
echo ""

if [ "$SHOW_HINTS" == false ] && [ $score -lt $total ]; then
    echo -e "${CYAN}💡 Tip: Run with hints enabled to see the commands for challenges you missed${NC}"
fi

echo -e "\n${YELLOW}Run again? Just type: bash ~/cyber_investigation/challenges/start.sh${NC}"
