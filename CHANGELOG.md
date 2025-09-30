# Changelog

## Latest Updates

### War-Game Style Challenge System

**Date**: 2025-09-29

#### What Changed

The challenge system is now a **war-game**, not a quiz:

**New Behavior:**
- 🎯 Get it **wrong**? Screen clears and question repeats
- 🚫 **No answers shown** - figure it out yourself
- ⚔️ **Keep trying** until you get it right
- 🏃 Type `skip` if you need to move on
- 🧹 **Clean screen** on every question

**Example Flow:**
```
═══════════════════════════════════════════════════════════
Challenge 1: Count lines containing IP 192.168.1.105 in access.log
═══════════════════════════════════════════════════════════

Hint: Try this command: grep -F '192.168.1.105' access.log | wc -l

Enter your answer (or 'skip' to skip): 3

❌ INCORRECT - Try again
[1.5 second pause, then screen clears and question repeats]

═══════════════════════════════════════════════════════════
Challenge 1: Count lines containing IP 192.168.1.105 in access.log
═══════════════════════════════════════════════════════════

Hint: Try this command: grep -F '192.168.1.105' access.log | wc -l

Enter your answer (or 'skip' to skip): 4

✅ CORRECT!
[Moves to next challenge]
```

**Skipping:**
```
Enter your answer (or 'skip' to skip): skip
⏭️  SKIPPED
```

#### Technical Details

**Function:** `prompt_and_check()`
- Clears screen on every attempt
- Shows only challenge number and question
- Displays hints if enabled
- Never reveals expected answer
- Loops until correct or skipped
- 1.5 second pause after wrong answer
- 1 second pause after correct/skip
- Returns 1 for correct, 0 for skip

**Files Modified:**
- `challenges/start.sh` - All 20 challenges updated

**Benefits:**
1. **War-game mentality**: Figure it out under pressure
2. **No crutches**: Can't see the answer, must solve it
3. **Clean focus**: Screen clears, no distractions
4. **Real training**: Simulates live incident response
5. **Interview ready**: Practice working under pressure

---

## Previous Updates

### File Reorganization (2025-09-29)

**Moved:**
- `scripts/verify.sh` → `challenges/start.sh`
- `scripts/answers.sh` → `challenges/solutions.sh`

**Updated Documentation:**
- README.md
- QUICK_REFERENCE.md
- ENHANCEMENTS.md

### Challenge Expansion (2025-09-29)

**Added:**
- 10 new advanced regex challenges (11-20)
- Expanded all log files 4-6x
- Total: 316+ log entries

**See:** ENHANCEMENTS.md for full details

---

## Usage

**Start challenges:**
```bash
bash ~/cyber_investigation/challenges/start.sh
```

**View solutions:**
```bash
bash ~/cyber_investigation/challenges/solutions.sh
```

**Tips:**
- Type exact answer to proceed
- Type `skip` to move to next challenge
- Hints mode shows commands
- Expert mode hides hints