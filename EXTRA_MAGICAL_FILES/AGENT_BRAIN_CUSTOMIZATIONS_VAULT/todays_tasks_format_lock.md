# 🔒 DAILY MISSION FORMAT LOCK — TODAYS_TASKS.TXT IMMUTABLE STANDARD
# Constitutional Law #13 Implementation — Verified Working Format (21 Aug 2026)
# This file locks the EXACT format, parser contract, and Vercel dashboard sync rules.

---

## SECTION 1: THE IMMUTABLE GOLDEN TEMPLATE

Every `TODAYS_TASKS.txt` file MUST follow this exact structure without any deviation:

```text
====================================================================
                  DAILY MISSION: DD MMM YYYY (DAY_OF_WEEK)
      [REAL-TIME STATUS / TAGLINE / SITUATION HEADER]
====================================================================

[!] MISSION OBJECTIVE: High-impact one-line objective for the day!

TOTAL STUDY TIME TODAY: X.X Hours (Breakdown in plain English)

--------------------------------------------------------------------
                       DAY SPRINT EXECUTION
--------------------------------------------------------------------
[ ] HH:MM AM - HH:MM PM : Sprint N — Sprint Title with Emoji ✍️
    -> Sub-action 1 detail (Target File / Command)
    -> Sub-action 2 detail
    -> Sub-action 3 detail

[-] HH:MM AM - HH:MM PM : Break / Recharge Title 🥗💤
    -> Break detail or mental reset note

--------------------------------------------------------------------
                    EVENING & LIVE CLASS BLOCK
--------------------------------------------------------------------
[x] 09:00 PM - 10:15 PM : LIVE DATA ENGINEERING CLASS (ONLINE BATCH 15 - DAY N) 🎓
    -> Live lecture focus areas and topics covered

--------------------------------------------------------------------
                 POST-CLASS NIGHT SPRINT BLOCK
--------------------------------------------------------------------
[ ] HH:MM PM - HH:MM AM : Sprint N — Night Sprint Title 🚀
    -> Task details

[ ] HH:MM AM - HH:MM AM : Final System Sync, GitHub Push & Vercel Trigger (Streak Day N 🔥) 🚀
    -> System sync details
    -> GitHub commit and push confirmation
    -> Mission Accomplished & Rest Window 🌙

====================================================================
*Rules: Zero Dropped Targets | Strict High-Precision Execution | Finish Before Sleep*
*Daily Quote: "When consistency meets strategy, every single sprint compounds toward 25+ LPA."*
====================================================================
```

---

## SECTION 2: PARSER CONTRACT — HOW THE VERCEL DASHBOARD READS THIS FILE

The `DASHBOARD/src/main.js` parser reads `TODAYS_TASKS.txt` using these STRICT rules:

### 2.1 Task Card Detection Regex
```
/^\[([xX\s\-]?)\]\s*([\d:]+\s*(?:AM|PM)\s*[-–]\s*[\d:]+\s*(?:AM|PM))\s*:\s*(.+)$/
```
A line is parsed as a task card ONLY if it starts with `[x]`, `[ ]`, or `[-]` followed by a time range.

### 2.2 Status Classification Logic

| Marker | Text | Parsed As | Dashboard Card Style |
| :---: | :--- | :--- | :--- |
| `[x]` | Any | `done` | ✅ Green completed card |
| `[ ]` | Any | `pending` | ⬜ White active sprint card |
| `[-]` | Contains break keyword | `break` | ☕ Dimmed recharge card |
| `[-]` | Does NOT contain break keyword | `deferred` | ⏳ Yellow deferred card |

### 2.3 Break Keywords (triggers break card type)
```
break | lunch | dinner | tea | relax | recharge | market | family | nap | sleep | meal | friends | walk
```
Any `[-]` line whose title contains one of these words (case-insensitive) = break card.
Any `[-]` line whose title does NOT contain a break keyword = deferred sprint card.

### 2.4 Progress Bar Formula
```
activeTotal  = count of tasks where (status === 'done' OR status === 'pending')
doneCount    = count of tasks where status === 'done'
progressPct  = Math.round((doneCount / activeTotal) * 100)
```
Breaks and deferred tasks are EXCLUDED from both numerator and denominator.

### 2.5 Sub-bullet Detection
```
/^\s{4}->\s(.+)$/
```
Lines indented with exactly 4 spaces followed by `->` are sub-bullets inside the parent task card.

---

## SECTION 3: SYNTAX RULES — MANDATORY, NON-NEGOTIABLE

### Rule 1: Single Time-Slot Header Per Card
Every executable task MUST begin with exactly:
```
[STATUS] HH:MM AM - HH:MM PM : Sprint Title
```
No variations. No alternative brackets. No different dash types.

### Rule 2: Sub-bullets use exactly 4 spaces + `-> `
```
    -> Description of sub-action
```
- 4 spaces (not a tab, not 2 spaces, not 8 spaces)
- Hyphen-greater-than followed by a space: `-> `

### Rule 3: Breaks use `[-]` with a break keyword in the title
```
[-] HH:MM AM - HH:MM PM : Lunch Break & Bio-Paced Mid-Day Recharge 🥗💤
```

### Rule 4: Deferred tasks use `[-]` WITHOUT a break keyword
```
[-] HH:MM PM - HH:MM AM : Sprint N — Deferred Task Title ⏳
```

### Rule 5: Completed tasks use `[x]` (lowercase or uppercase)
```
[x] HH:MM AM - HH:MM PM : Sprint N — Completed Sprint Title ✅
```

### Rule 6: Active pending tasks use `[ ]` (single space inside)
```
[ ] HH:MM PM - HH:MM AM : Sprint N — Pending Sprint Title 🚀
```

### Rule 7: Section headers are plain text between `----` dividers
```
--------------------------------------------------------------------
                       DAY SPRINT EXECUTION
--------------------------------------------------------------------
```
These are ignored by the parser. They are visual dividers only.

### Rule 8: The outer frame uses `====` (68 equal signs)
```
====================================================================
```
The parser ignores these lines. They are structural anchors for human readability.

### Rule 9: The footer quote is always the same
```
*Rules: Zero Dropped Targets | Strict High-Precision Execution | Finish Before Sleep*
*Daily Quote: "When consistency meets strategy, every single sprint compounds toward 25+ LPA."*
```

---

## SECTION 4: VERCEL AUTO-DEPLOY PIPELINE (NEVER SKIP)

After writing or modifying `TODAYS_TASKS.txt`, ALWAYS run:

```powershell
# Step 1: Copy task file to dashboard public folder
node copy_tasks.cjs

# Step 2: Build Vite production bundle
npm run build

# Step 3: Git add, commit, push — triggers Vercel auto-deploy
git add .
git commit -m "sync(dashboard): update daily mission and rebuild dashboard"
git push origin main
```

Working directory for Steps 1-2: `d:\DE COURSE\DASHBOARD\`
Working directory for Step 3: `d:\DE COURSE\`

The combined command:
```powershell
cd "d:\DE COURSE\DASHBOARD" ; node copy_tasks.cjs ; npm run build ; cd "d:\DE COURSE" ; git add . ; git commit -m "sync(dashboard): daily mission sync" ; git push origin main
```

---

## SECTION 5: SPRINT ORDER STANDARD

The canonical daily sprint order inside `TODAYS_TASKS.txt`:

1. **Note Re-write Sprint** — Re-write yesterday's class note + Read revision note
2. **Class Task Sprint** — Solve pending faculty-assigned class tasks in SSMS
3. **Practice Drills Sprint** — Solve 14-question practice drills
4. **Lunch / Bio Break** — Always `[-]` with "Lunch Break" in title
5. **Optional Bonus Sprint** — Project work, backlog clearance, LinkedIn
6. **Evening / Dinner Break** — Always `[-]` with "Dinner" or "Break" in title
7. **Live Class Block** — `09:00 PM - 10:15 PM` fixed slot
8. **Post-Class Night Sprint** — LinkedIn, social presence, or bonus study
9. **Final System Sync** — Always last. Always `[x]` after completion. Always includes GitHub push.

---

## SECTION 6: EXAMPLE LIVE FILE REFERENCE

The canonical verified working example is:
**`d:\DE COURSE\TODAYS_TASKS.txt` — 21 Aug 2026 version**
- 71 lines, 4,203 bytes
- Progress bar: 4 done / 5 active = 80% on Vercel ✅
- Parser: correctly classifies 3 breaks, 2 deferred, 4 done, 1 pending

---

## SECTION 7: FORBIDDEN PATTERNS (BREAKS THE PARSER)

These patterns MUST NEVER appear in `TODAYS_TASKS.txt`:

```text
❌ - [ ] 10:00 AM - 11:00 AM : Task (bare bullet before bracket = not detected)
❌ [ ]10:00 AM - 11:00 AM : Task (no space after bracket = regex miss)
❌ [X ] 10:00 AM : Task (no closing time = regex miss)
❌   -> Detail (2-space indent = not detected as sub-bullet)
❌ 	-> Detail (tab indent = not detected as sub-bullet)
❌ -> Detail (no indent = not detected as sub-bullet)
❌ [-] Sprint 3 (Deferred) (no time range = not detected as card at all)
❌ [d] 10:00 AM - 11:00 AM : Done (unknown marker = not parsed)
```

---

*This rule file is the single source of truth for TODAYS_TASKS.txt format.*
*Last verified: 21 Aug 2026 | Status: Production-Grade | Parser: v4.0*
*— Pippo 🐥*
