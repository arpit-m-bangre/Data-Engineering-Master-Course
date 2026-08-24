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
$$\text{Class Note Re-write} \longrightarrow \text{Read Revision Note} \longrightarrow \text{Solve Faculty Class Tasks} \longrightarrow \text{Solve Practice Drills}$$
*NEVER schedule practice drills without first scheduling the note rewrite and revision read for that day.*

### 2. Current-Focus First & Zero-Omission Standard:
- **Primary Daily Mission (Current Class First):** Prioritize the active/yesterday's live class day through the 4-stage pipeline (Re-write -> Revision -> Class Tasks -> Practice Drills) to guarantee 100% up-to-date momentum.
- **Backlog Decoupling:** Do not overload daily live schedules with past backlogs; early backlog clearance is systematically executed during Phase 3 Post-Course Revision Cycle 1.
- Every daily plan MUST include:
  * [ ] Active/yesterday's class tasks and practice drills.
  * [ ] 1 English Practice Book task (30 min).
  * [ ] 9:00 PM - 10:15 PM Live Data Engineering Class block (Mon-Sat).
  * [ ] Final System Sync, GitHub Push & Vercel Trigger sprint (Streak Day N 🔥).
  * [ ] Social Presence Sprint (20-30 min) on **Monday, Wednesday, and Saturday**.

### 3. Total Study Hours Calculation Protocol:
- Calculate the exact sum of all active study sprint durations (in hours).
- Exclude meal breaks, naps, and non-study windows.
- State at the top:
  `TOTAL STUDY TIME TODAY: X.X Hours (Summary breakdown)`

### 4. The 6-7-8 Hour Daily Planning Presets (24-48 LPA Tier Framework):
When planning daily missions, align with Cap's energy target:
- **6.0 Hours (Intense Deep Focus)**: Standard weekdays (3x 90-min coding blocks + Live Class + English).
- **7.0 Hours (Moderate Focus)**: Acceleration weekdays (4x 90-min coding blocks + Live Class + English).
- **8.0 Hours (Paced with Bio-Breaks)**: Weekend & holiday backlog clearance sprints with generous naps & meal windows.

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

$$\mathbf{Result:\text{ }6\text{ to }10\text{ Atomic Commits / Day}\longrightarrow\text{Level 4 Darkest Green Square Every Single Day!}\text{ 🟩🔥}}$$

