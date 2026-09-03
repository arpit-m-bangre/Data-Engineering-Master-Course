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
`Class Note Re-write -> Read Revision Note -> Solve Faculty Class Tasks -> Active Target Milestone -> Live Class`

### 2. Dual-Fleet Operational Scope:
- **WALL-E (8.5-Hour Job System):** Owns Deep Internals, Industrial Hands-on Building, Timed Coding, Sizing & Architecture, Speaking Aloud / Vocal English, Git Telemetry, and LinkedIn/Omni-Channel Engine.
- **Pippo 🐥 (4.5-Hour DE Course Engine):** Strictly schedules the pure academic and relational mastery pipeline:
  * [ ] **Pillar 1:** SSMS Class Note Manual Re-Write & Re-Do (1.0h).
  * [ ] **Pillar 2:** 7-Step Markdown Revision Read (0.5h).
  * [ ] **Pillar 3:** Faculty Class Tasks Mastery in SSMS (`04_CLASS_TASKS/` scripts) (1.0h).
  * [ ] **Pillar 4:** Active Short-Term Target / Bootcamp Sprint (0.75h).
  * [ ] **Pillar 5:** Live Faculty Class (09:00 PM - 10:15 PM, Mon-Sat, 1.25h).

### 3. User Stated Start Time & Zero Personal Assumptions Law:
- When Cap specifies a start time (e.g. *"Start day from 10:00 AM"* or *"11:00 AM"*), the daily plan MUST start Sprint 1 directly at that exact hour.
- **NEVER inject unrequested morning routine, grooming, bath, or chore cards** prior to Cap's stated start time unless Cap explicitly asks for them.

### 4. Total Study Hours Calculation Protocol:
- Calculate the exact sum of all active study sprint durations (in hours).
- Exclude meal breaks, naps, and non-study windows.
- State at the top:
  `TOTAL STUDY TIME TODAY: X.X Hours`

### 5. The Standard Daily Framework (32+ LPA Tier Framework):
- **Live Class Anchor:** 09:00 PM - 10:15 PM (Batch 15 Lecture)
- **Night Sleep Cutoff:** **10:45 PM** (Lights Out & Bio-Paced Health Recovery Sleep)

---

## 🔒 PHASE 3: PARSER-COMPATIBLE FORMAT LOCK (Vercel Contract)

Format every card strictly according to `.agents/rules/todays_tasks_format_lock.md`:

```text
====================================================================
                  DAILY MISSION: DD MMM YYYY (DAY_OF_WEEK)
      [REAL-TIME STATUS / TAGLINE / SITUATION HEADER]
====================================================================

[!] MISSION OBJECTIVE: One-line clear objective!

TOTAL STUDY TIME TODAY: X.X Hours (Breakdown summary)

--------------------------------------------------------------------
                       DAY SPRINT EXECUTION
--------------------------------------------------------------------
[ ] HH:MM AM - HH:MM PM : Sprint N — Sprint Title ✍️
    -> Specific actionable sub-bullet 1 (Target File / Command)
    -> Specific actionable sub-bullet 2

[-] HH:MM AM - HH:MM PM : Break / Recharge Title 🥗💤
    -> Break details

--------------------------------------------------------------------
                    EVENING & LIVE CLASS BLOCK
--------------------------------------------------------------------
[ ] 09:00 PM - 10:15 PM : LIVE DATA ENGINEERING CLASS (ONLINE BATCH 15 - DAY N) 🎓
    -> Live lecture focus areas

--------------------------------------------------------------------
                 POST-CLASS NIGHT SPRINT BLOCK
--------------------------------------------------------------------
[ ] HH:MM PM - HH:MM AM : Sprint N — Night Focus 🚀
    -> Task details

[ ] HH:MM AM - HH:MM AM : Final System Sync, GitHub Push & Vercel Trigger (Streak Day N 🔥) 🚀
    -> System sync and deploy confirmation

====================================================================
*Rules: Zero Dropped Targets | Strict High-Precision Execution | Finish Before Sleep*
*Daily Quote: "When consistency meets strategy, every single sprint compounds toward 25+ LPA."*
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

