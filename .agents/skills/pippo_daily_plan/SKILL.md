---
name: pippo_daily_plan
description: >-
  Daily task schedule and mission generator for Pippo in DE COURSE.
  Use when creating or updating TODAYS_TASKS.txt, planning daily study sprints,
  calculating study hours, enforcing sprint ordering, and deploying to Vercel.
---

# 📅 PIPPO DAILY MISSION & PLAN GENERATION PROTOCOL

This skill defines the mandatory protocol for generating `d:\DE COURSE\TODAYS_TASKS.txt` without omissions, errors, or format drift.

---

## ⚡ TRIGGER CONDITIONS
Activate this skill whenever:
- User asks "What should I do today?", "Make today's plan", or "Update TODAYS_TASKS.txt".
- User provides available hours for the day.
- A new day begins or sprints need rescheduling.

---

## 🛑 PHASE 1: MANDATORY PRE-PLAN READS (DO NOT WRITE BEFORE READING)

Before generating any plan, execute all 4 physical reads:
1. **READ `LEARNING_DIARY/MASTER_LEARNING_TRACKER.txt`**:
   - Identify all rows where `RE-WRITE NOTE = [ ] PENDING`.
   - Identify all rows where `REVISION NOTE = [ ] PENDING`.
   - Identify all rows where `PRACTICE DRILLS = [ ] PENDING`.
2. **READ `LEARNING_DIARY/METRICS_AND_STATISTICS.json`**:
   - Check current streak day number and completion status.
3. **CHECK `01_SQL/04_CLASS_TASKS/`**:
   - Check if the most recent `YYYY-MM-DD_CLASS_TASK.SQL` has unsolved query blocks.
   - If yes: it MUST be scheduled in today's plan.
4. **READ `.agents/TODAYS_TASKS_GOLDEN_TEMPLATE.txt`**:
   - Load the exact format, section dividers, and structural frame.

---

## 📋 PHASE 2: SPRINT COMPOSITION & ORDERING RULES

### 1. Mandatory Sprint Execution Order:
For any class day being worked on, the order MUST be strictly:
`IDE/Studio Note Re-write -> Read Revision Note -> Solve Faculty Class Tasks -> Smart Target Buffer (Optional) -> Live Class`

### 2. Dual-Fleet Operational Scope:
- **WALL-E (9-to-5 Job System / 8.5h):** Owns Deep Internals, Industrial Hands-on Building, Timed Coding, Sizing & Architecture, Speaking Aloud / Vocal English, Git Telemetry, and LinkedIn/Omni-Channel Engine.
- **Pippo 🐥 (Post-Job Dynamic 3.5h – 5.5h DE Course Engine):** Pure academic & multi-studio engineering mastery:
  * [ ] **Pillar 1:** Studio/IDE Note Manual Re-Write & Re-Do (SQL/SSMS, Python/VS Code, Power BI/DAX, PySpark/Databricks, Snowflake UI) (1.0h).
  * [ ] **Pillar 2:** 7-Step Markdown Revision Read (0.5h).
  * [ ] **Pillar 3:** Faculty Class Tasks & Challenge Mastery (1.0h).
  * [ ] **Pillar 4 (Smart Optional Buffer):** Active Milestone / Bootcamp Sprint (0.75h – 1.5h when active; smoothly omitted when bandwidth is tight or on light days).
  * [ ] **Pillar 5 (Elastic Live Lecture):** Live Faculty Class (Dynamic 09:00 PM – 10:15 PM+; flexes automatically with lecture duration).

### 3. User Stated Start Time & Zero Personal Assumptions Law:
- When Cap specifies a start time (e.g. *"Start day from 10:00 AM"* or *"11:00 AM"*), the daily plan MUST start Sprint 1 directly at that exact hour.
- **NEVER inject unrequested morning routine, grooming, bath, or chore cards** prior to Cap's stated start time unless Cap explicitly asks for them.

### 4. Dynamic Duration & Total Hours Protocol:
- Course total flexes dynamically between **3.5 Hours (light days)** to **5.5 Hours (extended live class / deep milestone days)**.
- Exclude meal breaks, naps, and non-study windows.
- State at the top:
  `TOTAL STUDY TIME TODAY: X.X Hours`

### 5. The Standard Daily Framework (32+ LPA Tier Framework):
- **Live Class Anchor:** 09:00 PM - 10:15 PM+ (Batch 15 Lecture)
- **Night Sleep Cutoff:** **10:45 PM** (Lights Out & Bio-Paced Health Recovery Sleep)

---

## 🔒 PHASE 3: PARSER-COMPATIBLE FORMAT LOCK (Vercel Contract)

Format every card strictly according to `.agents/rules/todays_tasks_format_lock.md`:

```text
====================================================================
                  DAILY MISSION: DD MMM YYYY (DAY_OF_WEEK)
      [STATUS: PIPPO DE COURSE FOCUS | X.X HOURS ACADEMIC & CLASS 🔥]
====================================================================

[!] MISSION OBJECTIVE: Brief one-line objective!

[🎯 CURRENT TARGET]: None

TOTAL STUDY TIME TODAY: X.X Hours (X.Xh Engineering + X.Xh Class)

--------------------------------------------------------------------
                    PIPPO DE COURSE STUDY SPRINTS
--------------------------------------------------------------------
[ ] HH:MM AM - HH:MM AM : Sprint 1 — [Topic] Note Re-Write & Revision (X.X Hours) 🚀
    -> Open [File Path] and study core concepts.
    -> Master key mental models, architectural flows, and production traps.

[-] HH:MM AM - HH:MM AM : Morning Rest & Recharge ☕🌿
    -> Screen-off, hydration, and light stretch.

[ ] HH:MM AM - HH:MM PM : Sprint 2 — Faculty Class Tasks & Practice Drills (X.X Hours) 🚀
    -> Open [File Path] and solve faculty tasks.
    -> Solve all 14 targeted practice drills.

[-] HH:MM PM - HH:MM PM : Lunch & Midday Recharge Break 🥗🚶
    -> Nutritious meal, walk, and rest.

--------------------------------------------------------------------
                    EVENING & LIVE CLASS BLOCK
--------------------------------------------------------------------
[ ] 09:00 PM - 10:15 PM : Sprint 3 — LIVE DATA ENGINEERING CLASS (ONLINE BATCH 15) 🎓
    -> Active attendance and real-time raw notes capture.

[ ] 10:15 PM - 10:30 PM : Sprint 4 — System Sync & GitHub Push (Streak Day N 🔥) 🚀
    -> Update trackers, rebuild dashboard, and push to GitHub.

[-] 10:30 PM - 07:00 AM : Rest & Bio-Paced Recovery Sleep 💤
    -> Wind down and 8 hours restorative sleep.

====================================================================
*Rules: Pure DE Course Focus | All Drills Solved | Finish Before Sleep*
*Daily Quote: "Mastery compounds sprint by sprint."*
====================================================================
```

### Syntax Enforcements:
- Active Sprint: `[ ] HH:MM AM/PM - HH:MM AM/PM : Sprint N — Title`
- Completed Sprint: `[x] HH:MM AM/PM - HH:MM AM/PM : Sprint N — Title`
- Break Window: `[-] HH:MM AM/PM - HH:MM AM/PM : Break Title` (contains break keyword)
- Deferred Sprint: `[-] HH:MM AM/PM - HH:MM AM/PM : Sprint N — Title (Deferred)` (no break keyword)
- Sub-bullets: Exactly 4 spaces followed by `-> ` (`    -> `)

---

## 🚀 PHASE 4: ATOMIC SPRINT COMMIT & DEPLOYMENT PIPELINE (4X-8X GREEN GRAPH)

Instead of batching all work into a single end-of-day commit, execute **Atomic Sprint Commits** immediately after each completed milestone:

```powershell
# Sprint Milestone Commit Pattern:
git add .
git commit -m "feat(sprint-N): [Milestone Title e.g. solve Day 18 faculty tasks]"
git push origin main
```

### Daily Milestone Commit Cadence (6-10 Commits/Day Target):
1. **Commit 1:** Daily mission plan initialization (`sync(dashboard): update daily mission for [DATE]`).
2. **Commit 2:** Social Presence / LinkedIn sprint artifact (`docs(linkedin): publish Post #N`).
3. **Commit 3:** Class Note re-write in SSMS (`feat(sql): solve Day N class note rewrite`).
4. **Commit 4:** Faculty Class Task solutions (`feat(sql): solve Day N faculty tasks`).
5. **Commit 5:** Practice Drills clearance (`test(drills): solve Day N Q1-Q14 practice drills`).
6. **Commit 6:** English Practice Book task (`docs(english): complete task N`).
7. **Commit 7:** Live Class Notes capture & ecosystem sync (`feat(sql): add Day N ecosystem`).
8. **Commit 8:** Final System Sync, Trackers & Dashboard deploy (`sync(dashboard): daily mission complete`).

*Result: 6 to 10 Atomic Commits / Day -> Level 4 Darkest Green Square Every Single Day! 🟩🔥*

