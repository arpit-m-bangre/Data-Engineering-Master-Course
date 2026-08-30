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
`Class Note Re-write -> Read Revision Note -> Solve Faculty Class Tasks -> Solve Practice Drills`
*NEVER schedule practice drills without first scheduling the note rewrite and revision read for that day.*

### 2. The 8-Pillar Current-Focus & Zero-Omission Standard:
- **Primary Daily Mission (Current Class First):** Prioritize the active/yesterday's live class day through the 4-stage pipeline (Re-write -> Revision -> Class Tasks -> Practice Drills) to guarantee 100% up-to-date momentum.
- **Backlog Decoupling:** Do not overload daily live schedules with past backlogs; early backlog clearance is systematically executed during Phase 3 Post-Course Revision Cycle 1.
- Every daily plan MUST incorporate all 9 core pillars (targeting standard 9.0 Hours study):
  * [ ] **Pillar 1 (Career & Social Authority — 1.0h Total):** 60-Minute Omni-Channel Authority Engine. (1) First 30 Mins — LinkedIn: Post on daily concept + 5-7 Tier-1 connections (Walmart, Swiggy) + 3 comments. (2) Second 30 Mins — 50-Platform Distribution: Execute today's active 10-day campaign from `PERSONAL_BRANDING/50_PLATFORM_MASTER_DIGITAL_AUTHORITY_AND_BADGES_ROADMAP.md` (Pinterest, Dev.to, SlideShare, LeetCode, HackerRank Badges).
  * [ ] **Pillar 2:** Pre-Revision Class Note Re-write & 7-Step Revision Read in SSMS (1.50h).
  * [ ] **Pillar 3:** Faculty Class Tasks Mastery in SSMS (1.50h).
  * [ ] **Pillar 4:** Practice Drills Clearance (14 Drills in SSMS) + Perpetual SQL Practice (1.50h).
  * [ ] **Pillar 5:** Flagship MNC Project: NexusFin Platform Pipeline Sprints (1.50h).
  * [ ] **Pillar 6:** English Practice Book Task (0.50h: 1 task daily, cycling 1 to 125).
  * [ ] **Pillar 7:** Pre-Class Warmup & Readiness (0.25h).
  * [ ] **Pillar 8:** Live Data Engineering Class (09:00 PM - 10:15 PM, Mon-Sat, 1.25h).
  * [ ] **Pillar 9 (Launches Monday 31 Aug 2026):** Compulsory 210-Day IG/Shorts Publishing (10:15 PM - 10:30 PM, 0.0 Study Hr Impact, active starting Monday 31 Aug 2026 Day 001) + Final System Sync & GitHub Push (10:30 PM - 10:45 PM, 0.25h). NEVER schedule prior to Monday 31 Aug 2026.

### 3. User Stated Start Time & Zero Personal Assumptions Law:
- When Cap specifies a start time (e.g. *"Start day from 11:00 AM"*), the daily plan MUST start Sprint 1 directly at that exact hour.
- **NEVER inject unrequested morning routine, grooming, bath, or chore cards** prior to Cap's stated start time unless Cap explicitly asks for them.

### 3. Total Study Hours Calculation Protocol:
- Calculate the exact sum of all active study sprint durations (in hours).
- Exclude meal breaks, naps, and non-study windows.
- State at the top:
  `TOTAL STUDY TIME TODAY: X.X Hours (Summary breakdown across all 8 pillars)`

### 4. The Standard Daily Framework (32+ LPA Tier Framework):
- **Anchor A (Start):** 11:30 AM (Cockpit Startup & Daily LinkedIn)
- **Anchor B (Live Class):** 09:00 PM - 10:15 PM (Batch 15 Lecture)
- **Anchor C (Night Cutoff):** **10:45 PM** (Lights Out & Bio-Paced Health Recovery Sleep)
- **Total Study & Engineering Time:** **7.00 to 9.00 Hours Daily**.

### 5. Zero-Shrink Allotted Time Standard:
- **Never Compress Deep-Work Time for Convenience:** If learning a concept, re-writing notes, or solving drills requires $X$ hours of focused effort, Pippo MUST NOT compress it to $X - Y$.
- **Adjust Timetables, Not Learning Depth:** When unexpected delays or outside events happen, manage the schedule (extend bedtime with protected 7h sleep shifted accordingly, shift buffers) while preserving 100% of study hours and deliverable depth.

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

