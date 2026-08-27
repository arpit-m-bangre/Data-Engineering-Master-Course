# 🔒 DAILY MISSION FORMAT LOCK — TODAYS_TASKS.TXT IMMUTABLE STANDARD
# Constitutional Law #13 Implementation — Verified Working Format (21 Aug 2026)
# This file locks the EXACT format, parser contract, and Vercel dashboard sync rules.

---

## SECTION 1: THE IMMUTABLE GOLDEN TEMPLATE

Every `TODAYS_TASKS.txt` file MUST follow this exact structure without any deviation:

```text
====================================================================
                  DAILY MISSION: DD MMM YYYY (DAY_OF_WEEK)
   [STATUS: GREEN | DAY TYPE: BUILD | P1: SQL & P7: PROJECT | STREAK DAY N 🔥]
====================================================================

[!] MISSION OBJECTIVE: High-impact one-line objective for the day!

[MUST-WIN 1] Master: [Concept + measurable mastery test]
[MUST-WIN 2] Build: [Project feature + verifiable deliverable]
[MUST-WIN 3] Prove: [Timed problems / interview score / explanation]
[SHOULD-WIN] [Revision, communication or career-development outcome]
[BONUS]      [Optional drill, dashboard improvement or additional networking]

TOTAL STUDY TIME TODAY: 8.25 Hours (P1: 1.75h | P2/P7: 1.75h | P8: 1.0h | Class: 1.25h | Drills: 1.25h | Recall: 1.25h)

--------------------------------------------------------------------
                MORNING SYSTEM BOOT & PRIORITIZATION
--------------------------------------------------------------------
[-] 07:30 AM - 08:00 AM : Wake-Up, Performance Activation & Morning Recharge Window ☀️🥗
    -> Hydration, sunlight, mobility and protein-rich breakfast
    -> Review yesterday's error log and spaced-repetition queue
    -> Select exactly three must-win outcomes; phone kept outside cockpit

--------------------------------------------------------------------
                        DAY SPRINT EXECUTION
--------------------------------------------------------------------
[ ] 08:00 AM - 09:45 AM : Sprint 1 — Core Technical Deep Work (P1/P2/P5) 🧠
    -> Learn one clearly bounded concept; solve N unfamiliar problems independently
    -> Explain aloud: Definition -> Why it matters -> Example -> Trade-off -> Failure case
    -> Record mistakes and misconceptions in the Error Log
    -> [DoD]: Output tested with edge cases | No copy-paste | Recall score recorded

[-] 09:45 AM - 10:00 AM : Eye Recovery, Hydration & Break Window ☕
    -> Eye relaxation, hydration and quick screen break

[ ] 10:00 AM - 11:15 AM : Sprint 2 — Active Recall & Class Consolidation [DATE] ✍️
    -> 15-min closed-book recall of [DATE/TOPIC] before opening notes
    -> Re-write missing logic & edge cases in 01_SQL/01_CLASS_NOTES/YYYY-MM-DD.sql
    -> Review 01_SQL/03_REVISION_NOTES/YYYY-MM-DD_REVISION.md & solve faculty class tasks
    -> [DoD]: Queries validated in SSMS | Class tasks solved | Bug traps logged

[-] 11:15 AM - 12:00 PM : Lunch Break & Mid-Day Recovery Walk 🥗💤
    -> Nutritious meal, hydration and complete screen-free break

[ ] 12:00 PM - 01:45 PM : Sprint 3 — Production Data Engineering Project (P7: NexusFin) 🏗️
    -> Build deployable slice: Ingestion -> Transformation -> Validation -> Storage
    -> Add meaningful tests, logging, failure handling and architecture decisions
    -> [DoD]: Feature works end-to-end | Tests pass | Able to explain design in <3 mins

[-] 01:45 PM - 02:30 PM : Rest & Bio-Paced Mental Recharge Window 💤
    -> Power nap, eye relaxation or quiet physical rest; zero social media

[ ] 02:30 PM - 03:45 PM : Sprint 4 — Timed Interview & Practice Drills (01_SQL/05_INDEX_WISE_QUESTIONS) 💪
    -> Complete 14 targeted problems under strict interview conditions (no AI/notes)
    -> Review execution plans in SSMS; re-solve any failed problems from blank editor
    -> [DoD]: Accuracy & time tracked | All failed drills re-solved independently

--------------------------------------------------------------------
                   HEALTH & SOCIAL RECOVERY BLOCK
--------------------------------------------------------------------
[-] 03:45 PM - 04:30 PM : Exercise, Physical Workout & Recovery Walk 🏃
    -> Strength training, brisk walking, mobility or sport; shower & posture reset

[-] 04:30 PM - 05:00 PM : Friends, Family & Social Relaxation Window 🤝☕
    -> Guilt-free social recovery & tea; return sharp at 05:00 PM

--------------------------------------------------------------------
                    CAREER & COMMUNICATION ENGINE
--------------------------------------------------------------------
[ ] 05:00 PM - 06:00 PM : Sprint 5 — 60-Min Omni-Channel Authority, LinkedIn & Distribution Engine (P8) 🚀
    -> Publish 1 #180DaysOfDataEngineering post on LinkedIn + 5-7 Tier-1 personalized connection requests
    -> Leave 3 high-value technical comments on Senior Data Architect posts
    -> Upload 1-2 SQL/Architecture visual cheat sheets to Pinterest & Dev.to linking to GitHub
    -> Syndicate key technical takeaways/snippets to Twitter/X and GitHub Discussions
    -> [Rule]: Strict 60-min cutoff; high-leverage multi-platform authority distribution

[ ] 06:00 PM - 06:30 PM : Sprint 6 — English & Technical Communication (Task N/125) 🎙️
    -> Complete English Practice Book Task N (N/125 total)
    -> Record 2-min verbal explanation of today's technical concept & 1 STAR answer

[-] 06:30 PM - 07:15 PM : Protected Flex, Catch-Up & Rest Buffer 🛡️
    -> Buffer window: Recover top-priority unfinished Must-Win OR take walk/rest

[-] 07:15 PM - 08:15 PM : Personal Reset, Pre-Class Readiness & Dinner Setup 🌿🍽️
    -> Light meal preparation, household reset; 10-min pre-class topic overview

--------------------------------------------------------------------
                     EVENING & LIVE CLASS BLOCK
--------------------------------------------------------------------
[-] 08:15 PM - 09:00 PM : Dinner Break & Pre-Class SSMS Warmup 🍽️💻
    -> Light nutritious dinner; launch SSMS and setup workspace

[ ] 09:00 PM - 10:15 PM : LIVE DATA ENGINEERING CLASS (ONLINE BATCH 15 - DAY N) 🎓
    -> Live lecture: [TOPIC NAME]
    -> Capture raw notes, instructor tips & mark [?] flags for tomorrow's consolidation

--------------------------------------------------------------------
                  POST-CLASS NIGHT SYNC & REST BLOCK
--------------------------------------------------------------------
[-] 10:15 PM - 10:30 PM : Post-Class Quick Stretch & Hydration Window ☕
    -> Quick stretch, hydration transition to final system sync

[ ] 10:30 PM - 10:45 PM : Evidence Sync, GitHub Push & Vercel Trigger (Streak Day N 🔥) 🚀
    -> Sync Master Learning Tracker, Metrics JSON, Concept Heatmap & Dashboard
    -> Run: node copy_tasks.cjs && npm run build (in DASHBOARD/)
    -> Commit and push verified evidence to GitHub; confirm live Vercel deploy

[-] 10:45 PM - 07:30 AM : Deep Sleep & Biological Recovery Window 🌙💤
    -> 8 hours 45 minutes of protected sleep; cockpit fully shut down

====================================================================
*Rules: Must Win -> Should Win -> Bonus | Zero Silent Dropping | Sleep Protected*
*Daily Quote: "Build proof, correct mistakes and compound capability toward 32+ LPA."*
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

# Step 3: Git add, commit, push — triggers Vercel auto-deploy (Zero-Hang Guaranteed)
$env:GCM_INTERACTIVE="never"
git add .
git commit -m "sync(dashboard): update daily mission and rebuild dashboard"
git push origin main
```

Working directory for Steps 1-2: `d:\DE COURSE\DASHBOARD\`
Working directory for Step 3: `d:\DE COURSE\`

The combined command:
```powershell
cd "d:\DE COURSE\DASHBOARD" ; node copy_tasks.cjs ; npm run build ; cd "d:\DE COURSE" ; $env:GCM_INTERACTIVE="never" ; git add . ; git commit -m "sync(dashboard): daily mission sync" ; git push origin main
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
