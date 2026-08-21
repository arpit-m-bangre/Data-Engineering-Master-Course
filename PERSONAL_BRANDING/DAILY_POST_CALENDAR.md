# 📅 LINKEDIN DAILY POST CALENDAR — #90DaysOfDataEngineering
## Starting 22 August 2026 | Theme-Synced | Viral-First | Zero Fresher Framing

**Format Legend:**
- **Hook:** The first line — creates a knowledge gap, forces "See More"
- **Format:** Text / Carousel / Code Snippet / Story / List
- **Viral Angle:** Why this specific post will spread
- **Hashtags:** Pre-selected for maximum reach

---

## 🔷 PHASE 1: SQL ENGINE INTERNALS (Aug 22 — Sep 5, 2026) — Posts 1 to 15

---

### Post 1 — Friday, 22 Aug 2026

**Hook:**
> 99% of SQL developers use JOIN every day. Less than 10% know what actually happens inside the engine.

**Format:** Text (Deep Dive)
**Topic:** How SQL JOIN works internally — Nested Loop, Hash Match, Merge Join — and how the optimizer picks one
**Talking Points:**
- Nested Loop: Best for small tables. O(n*m) complexity.
- Hash Match: Best for large unsorted tables. Builds a hash bucket in memory.
- Merge Join: Fastest — requires BOTH tables pre-sorted on join key.
- The optimizer picks wrong if stats are stale — leading to invisible slowdowns.
- Fix: `UPDATE STATISTICS TableName` or rebuild indexes to refresh stats.

**Viral Angle:** "What ACTUALLY happens" format always outperforms "here's how to use" format. Engineers share this to look smart.
**Hashtags:** `#SQL #DataEngineering #QueryOptimization #DatabaseInternals #90DaysOfDataEngineering #DataEngineer #SQLServer #BigData`

---

### Post 2 — Saturday, 23 Aug 2026

**Hook:**
> LEFT JOIN and NOT IN do not give the same result. This cost our team 3 hours of debugging once.

**Format:** Code Snippet + Explanation
**Topic:** The NULL trap in NOT IN vs LEFT JOIN + IS NULL anti-join
**Talking Points:**
- `NOT IN` with a subquery silently returns zero rows if ANY value in the list is NULL.
- `LEFT JOIN ... WHERE right_key IS NULL` always works correctly.
- Rule: If the subquery column has even 1 NULL, `NOT IN` is broken.
- Safe alternative: `NOT EXISTS` with a correlated subquery.

```sql
-- DANGEROUS: Returns 0 rows if Orders has any NULL CustomerID
SELECT CustomerID FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- SAFE: Anti-Join pattern that handles NULLs correctly
SELECT C.CustomerID FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL;
```

**Viral Angle:** "This cost me hours" + working code = instant save + reshare.
**Hashtags:** `#SQL #NullTrap #DataEngineering #SQLTips #AntiJoin #90DaysOfDataEngineering #QueryOptimization`

---

### Post 3 — Sunday, 24 Aug 2026

**Hook:**
> A Self Join sounds confusing. It's actually one of the most elegant SQL patterns once you see it.

**Format:** Carousel (5 slides)
**Topic:** Self Join — when a table talks to itself
**Slide Structure:**
- Slide 1: Title — "Self Join: A Table That Joins Itself"
- Slide 2: What is a Self Join? (The mirror analogy — 2 aliases, 1 table)
- Slide 3: Real Use Case 1 — Find employees earning more than their manager
- Slide 4: Real Use Case 2 — Find duplicate emails with different IDs
- Slide 5: The golden rule — always use E1.ID < E2.ID to avoid duplicate pairs

**Viral Angle:** Carousels get 3-5x more reach. "This sounds complex but here's how simple it is" framing is extremely shareable.
**Hashtags:** `#SQL #SelfJoin #DataEngineering #SQLTips #CareerDevelopment #90DaysOfDataEngineering`

---

### Post 4 — Monday, 25 Aug 2026

**Hook:**
> TRUNCATE and DELETE both empty a table. But they work completely differently under the hood.

**Format:** Text + Comparison Table
**Topic:** TRUNCATE vs DELETE — the deep technical difference
**Talking Points:**
- DELETE: Row-by-row removal, logs every row deletion in LDF file, fires triggers, slow on large tables.
- TRUNCATE: Deallocates entire data pages — logs only page deallocations, no row-level logging.
- Common myth: "TRUNCATE cannot be rolled back." FALSE in SQL Server inside a transaction.
- TRUNCATE resets IDENTITY counter. DELETE does not.
- TRUNCATE cannot have WHERE clause. Cannot be used on tables with FK references.

**Viral Angle:** Busting a myth ("cannot be rolled back") generates strong comment engagement from both believers and skeptics.
**Hashtags:** `#SQL #TRUNCATE #DELETE #DataEngineering #SQLServer #DatabaseDesign #90DaysOfDataEngineering`

---

### Post 5 — Tuesday, 26 Aug 2026

**Hook:**
> RANK() and DENSE_RANK() look identical — until they don't. And by then you've already sent wrong data to production.

**Format:** Code Snippet + Table Output
**Topic:** ROW_NUMBER vs RANK vs DENSE_RANK — exact difference with examples
**Talking Points:**
- All 3 are Window Functions — need `OVER (PARTITION BY ... ORDER BY ...)`.
- ROW_NUMBER: No ties. Always unique sequential integers.
- RANK: Ties get same rank, then skips (1, 1, 3).
- DENSE_RANK: Ties get same rank, no skipping (1, 1, 2).
- Real use case: Salary leaderboards, sales rankings, de-duplication.

```sql
SELECT EmployeeName, Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum,
    RANK()       OVER (ORDER BY Salary DESC) AS SalaryRank,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;
```

**Viral Angle:** Concrete code with expected output table makes this one of the most-saved posts in data engineering.
**Hashtags:** `#SQL #WindowFunctions #RANK #DENSERANK #DataEngineering #SQLTips #90DaysOfDataEngineering`

---

### Post 6 — Wednesday, 27 Aug 2026

**Hook:**
> LEAD() and LAG() changed how I think about time-series data completely.

**Format:** Code Snippet + Use Case Story
**Topic:** LEAD and LAG — comparing current row with next/previous row
**Talking Points:**
- LAG: Access previous row's value in ordered result without a self-join.
- LEAD: Access next row's value.
- Use cases: Month-over-month revenue change, consecutive day gap detection, churn prediction.
- Can replace complex self-joins in 90% of time-series scenarios.

```sql
SELECT OrderDate, Revenue,
    LAG(Revenue) OVER (ORDER BY OrderDate)  AS PrevMonthRevenue,
    Revenue - LAG(Revenue) OVER (ORDER BY OrderDate) AS MoMGrowth
FROM MonthlySales;
```

**Viral Angle:** Time-series is everywhere. This is immediately applicable to every analyst and DE.
**Hashtags:** `#SQL #LEAD #LAG #WindowFunctions #TimeSeries #DataEngineering #90DaysOfDataEngineering`

---

### Post 7 — Thursday, 28 Aug 2026

**Hook:**
> A CROSS JOIN can destroy your database server in 3 seconds. Here's why — and when to actually use one.

**Format:** Text + Math Proof
**Topic:** CROSS JOIN — the Cartesian explosion, when it is useful vs catastrophic
**Talking Points:**
- CROSS JOIN = every row from Table A paired with every row from Table B.
- Math: 1,000 rows x 1,000 rows = 1,000,000 rows. 1M x 1M = 1 trillion rows. Server crashes.
- Accidental CROSS JOIN in old-style comma syntax: `SELECT * FROM A, B` — no ON clause = implicit CROSS JOIN.
- Legitimate use cases: Generating date grids, test data multiplication, probability matrices.

**Viral Angle:** "Can destroy your server" is a fear-based hook that data engineers forward to their teams.
**Hashtags:** `#SQL #CROSSJOIN #DataEngineering #SQLTips #DatabaseDesign #CarteProduct #90DaysOfDataEngineering`

---

### Post 8 — Friday, 29 Aug 2026

**Hook:**
> Most people write CTEs for readability. The real power is when you make them recursive.

**Format:** Carousel (6 slides)
**Topic:** Recursive CTEs — traversing org charts and hierarchical data
**Slide Structure:**
- Slide 1: Title — "Recursive CTEs: The Query That Calls Itself"
- Slide 2: What is a Recursive CTE? (Anchor + Recursive member)
- Slide 3: The syntax template
- Slide 4: Live example — Employee -> Manager hierarchy tree
- Slide 5: Live example — Category -> Subcategory explosion
- Slide 6: The MAXRECURSION guard to prevent infinite loops

**Viral Angle:** Org chart and hierarchy are universal. Every DE, analyst, and developer faces this. Very shareable.
**Hashtags:** `#SQL #CTE #RecursiveCTE #DataEngineering #HierarchicalData #SQLAdvanced #90DaysOfDataEngineering`

---

### Post 9 — Saturday, 30 Aug 2026

**Hook:**
> PRIMARY KEY and UNIQUE constraint are NOT the same thing. Most developers treat them identically and pay for it later.

**Format:** Text + Comparison Table
**Topic:** PK vs UNIQUE — the 4 critical differences
**Talking Points:**
- PK: Automatically creates clustered index. UNIQUE: Creates non-clustered index (by default).
- PK: NEVER allows NULL. UNIQUE: Allows ONE NULL in SQL Server (NULL is considered unique).
- PK: Only 1 per table. UNIQUE: Multiple per table.
- PK: Physical row ordering anchor of the table. UNIQUE: Just an integrity rule.

**Viral Angle:** Misconceptions about fundamentals = explosive engagement from both beginners correcting themselves and seniors validating.
**Hashtags:** `#SQL #PrimaryKey #UniqueConstraint #DatabaseDesign #DataEngineering #SQLServer #90DaysOfDataEngineering`

---

### Post 10 — Sunday, 31 Aug 2026

**Hook:**
> IDENTITY(1,1) does NOT guarantee gap-free sequential IDs. Here's what actually happens.

**Format:** Code Snippet + Explanation
**Topic:** IDENTITY gaps — why they happen and how to handle them
**Talking Points:**
- INSERT failure after IDENTITY increment = gap. The seed advances even on rollback.
- DELETE rows = gaps remain (IDENTITY never reassigns).
- DBCC CHECKIDENT: How to reseed the counter.
- The real solution: Never use IDENTITY as a business key. It is a surrogate key only.
- Alternative for gap-free: SEQUENCE objects with cycling.

**Viral Angle:** "Something you assumed works correctly — doesn't" is the highest-engagement SQL post format.
**Hashtags:** `#SQL #IDENTITY #DatabaseDesign #DataEngineering #SQLServer #90DaysOfDataEngineering #SQLTips`

---

### Post 11 — Monday, 1 Sep 2026

**Hook:**
> FOREIGN KEY is not just a data quality tool. It is a query optimizer hint disguised as a constraint.

**Format:** Text (Deep Dive)
**Topic:** What FK constraints ACTUALLY do to query execution plans
**Talking Points:**
- FK tells the optimizer "this join will always find a match" — enabling plan shortcuts.
- Without FK, optimizer might choose a less efficient join strategy.
- FK prevents orphan records at the engine level — no application code can bypass it.
- When to drop FK temporarily: Large bulk inserts. Always re-enable with CHECK after.
- Disable FK: `ALTER TABLE Orders NOCHECK CONSTRAINT FK_CustomerID`

**Viral Angle:** "It's not just what you think it is" reframes a common concept with new depth.
**Hashtags:** `#SQL #ForeignKey #QueryOptimizer #DataEngineering #DatabaseDesign #90DaysOfDataEngineering`

---

### Post 12 — Tuesday, 2 Sep 2026

**Hook:**
> Temp tables, table variables, and CTEs all store intermediate results. They are NOT interchangeable.

**Format:** Carousel (5 slides)
**Topic:** #temp tables vs @TableVariables vs CTEs — definitive comparison
**Slide Structure:**
- Slide 1: Title — "Which One Should You Use? (It Depends)"
- Slide 2: CTE — No physical storage, re-evaluated each time it's referenced, great for readability
- Slide 3: @TableVariable — Stored in memory (mostly), no stats, tiny result sets only
- Slide 4: #TempTable — Stored in TempDB, has stats, best for large intermediate datasets, supports indexes
- Slide 5: Decision flowchart — CTE for readability, @var for <1,000 rows, #temp for everything larger

**Viral Angle:** Carousels + decision framework = most saved format in DE community.
**Hashtags:** `#SQL #TempTables #CTE #DataEngineering #QueryOptimization #SQLPerformance #90DaysOfDataEngineering`

---

### Post 13 — Wednesday, 3 Sep 2026

**Hook:**
> DATEDIFF returns the number of boundaries crossed — not the actual elapsed time. This is a silent bug in most date logic.

**Format:** Code Snippet + Bug Proof
**Topic:** DATEDIFF boundary-crossing trap
**Talking Points:**
- `DATEDIFF(DAY, '2026-08-31 23:59:59', '2026-09-01 00:00:01')` = 1 day, but only 2 seconds elapsed.
- DATEDIFF counts how many YEAR/MONTH/DAY/HOUR boundaries are crossed, not actual elapsed time.
- Real elapsed time: Use `DATEDIFF(SECOND, ...)` then convert to minutes/hours yourself.
- Affects: Age calculation, SLA measurement, consecutive day detection.

**Viral Angle:** "Silent bug in most code" + concrete proof = guaranteed saves and reshares.
**Hashtags:** `#SQL #DATEDIFF #SQLBug #DataEngineering #DateFunctions #90DaysOfDataEngineering`

---

### Post 14 — Thursday, 4 Sep 2026

**Hook:**
> The ORDER BY clause in your SELECT is NOT guaranteed to produce sorted results in a subquery or CTE. This one surprised everyone on our team.

**Format:** Text + Example
**Topic:** ORDER BY in subqueries is meaningless — only the outermost ORDER BY is guaranteed
**Talking Points:**
- SQL standard: A subquery or CTE with ORDER BY does not guarantee order in the output.
- The query engine can ignore ORDER BY inside derived tables.
- Common bug: Developers expect TOP 10 + ORDER BY inside subquery to stay sorted when wrapped.
- Fix: Always put ORDER BY on the OUTERMOST query.

**Viral Angle:** Counterintuitive + commonly assumed wrong = high debate + comments.
**Hashtags:** `#SQL #ORDERBY #DataEngineering #SQLInternals #QueryExecution #SQLTips #90DaysOfDataEngineering`

---

### Post 15 — Friday, 5 Sep 2026

**Hook:**
> GROUP BY runs before HAVING. WHERE runs before GROUP BY. Getting this order wrong means wrong data in your aggregations.

**Format:** Visual List + Order Diagram
**Topic:** SQL logical execution order — the real sequence the engine follows
**The Real Order:**
1. FROM (and JOINs)
2. WHERE (filters rows)
3. GROUP BY (groups remaining rows)
4. HAVING (filters groups)
5. SELECT (computes columns)
6. DISTINCT (removes duplicates)
7. ORDER BY (sorts final output)
8. TOP/LIMIT/FETCH (trims rows)

**Viral Angle:** The execution order diagram is one of the most pinned, saved, reshared SQL graphics in the world. Every version gets thousands of shares.
**Hashtags:** `#SQL #SQLExecutionOrder #DataEngineering #SQLInternals #DataEngineer #90DaysOfDataEngineering #LearnSQL`

---

## 🔷 PHASE 2: CONSTRAINTS, PERFORMANCE & ADVANCED SQL (Sep 6 — Sep 20, 2026) — Posts 16 to 30

---

### Post 16 — Saturday, 6 Sep 2026

**Hook:**
> A clustered index IS the table. Not an addition to it. This changes how you design tables entirely.

**Format:** Carousel (6 slides)
**Topic:** Clustered vs Non-Clustered Index — the physical storage truth
**Viral Angle:** "IS the table" is a mind-shift statement. High save rate from developers who never thought about it this way.

---

### Post 17 — Sunday, 7 Sep 2026

**Hook:**
> Your query works perfectly on 10,000 rows. On 10,000,000 rows it times out. Here's the diagnostic playbook.

**Format:** Story + Numbered List
**Topic:** Query performance investigation — 5 steps to find and fix slow queries
**Viral Angle:** Practical troubleshooting playbook = immediate utility, extremely shareable by team leads.

---

### Post 18 — Monday, 8 Sep 2026

**Hook:**
> CHECK constraint is free data validation that never fails silently. Stop writing application-layer validation for data that belongs in the database.

**Format:** Code Snippet
**Topic:** CHECK constraints — enforcing business rules at the engine level
**Viral Angle:** "Stop doing X, the database can do it for free" is a strong pattern-change post.

---

### Post 19 — Tuesday, 9 Sep 2026

**Hook:**
> I ran the same query 3 ways. The results were identical. The execution times were 2ms, 890ms, and 4 seconds.

**Format:** Code Snippet + Benchmark Table
**Topic:** SARGable vs Non-SARGable predicates — why wrapping columns in functions kills indexes
**Viral Angle:** Concrete benchmark numbers create high engagement and credibility.

---

### Post 20 — Wednesday, 10 Sep 2026

**Hook:**
> ROLLUP and CUBE are the most underused SQL features for analytics. Here's what they do in one diagram.

**Format:** Carousel (5 slides)
**Topic:** GROUPING SETS, ROLLUP, CUBE — multi-dimensional aggregation without multiple queries
**Viral Angle:** Most SQL developers have never used ROLLUP. "I didn't know this existed" comments drive massive reach.

---

### Post 21 — Thursday, 11 Sep 2026

**Hook:**
> ACID is not just a database buzzword. Each letter represents a promise your database makes to you — and can break.

**Format:** Text (Deep Dive)
**Topic:** ACID properties — Atomicity, Consistency, Isolation, Durability with real-world failure examples
**Viral Angle:** "Can break" creates urgency. ACID is referenced in every DE interview.

---

### Post 22 — Friday, 12 Sep 2026

**Hook:**
> Transaction isolation levels are the most important setting most developers never change.

**Format:** Carousel (6 slides)
**Topic:** READ UNCOMMITTED vs READ COMMITTED vs REPEATABLE READ vs SERIALIZABLE — when to use which
**Viral Angle:** Isolation levels are universally misunderstood and asked in every Tier-1 interview.

---

### Post 23 — Saturday, 13 Sep 2026

**Hook:**
> Deadlocks are not random. They always follow the same pattern. Once you see it, you can prevent them.

**Format:** Story + Diagram
**Topic:** Deadlock anatomy — the lock cycle, how to read deadlock graphs, prevention strategies
**Viral Angle:** Real debugging story format + diagram = highest engagement post type in the DE community.

---

### Post 24 — Sunday, 14 Sep 2026

**Hook:**
> The difference between a correlated subquery and a regular subquery is not just syntax — it's a performance cliff.

**Format:** Code Snippet + Execution Comparison
**Topic:** Correlated vs non-correlated subquery — execution behavior and performance impact
**Viral Angle:** Performance comparison with actual run times creates high save rate.

---

### Post 25 — Monday, 15 Sep 2026 🏆 MILESTONE POST

**Hook:**
> 25 days of posting. 25 concepts. Here's the full SQL cheatsheet — one line per concept.

**Format:** Long-form List (25 items)
**Topic:** 25-post milestone recap — one-liner mastery reference for every concept covered
**Viral Angle:** Cheatsheet posts are the #1 most-saved format on LinkedIn. This will compound in reach for weeks.

---

### Post 26 — Tuesday, 16 Sep 2026

**Hook:**
> INTERSECT handles NULLs. INNER JOIN does not. Here's why the same-looking query gives different results.

**Format:** Code Snippet + Output Comparison
**Topic:** Set operators vs Joins — UNION, INTERSECT, EXCEPT vs JOIN semantics
**Viral Angle:** Counterintuitive result tables generate high "wait, really?" comment engagement.

---

### Post 27 — Wednesday, 17 Sep 2026

**Hook:**
> A covering index can make a query 50x faster without changing a single line of SQL.

**Format:** Text + Benchmark
**Topic:** Covering indexes with INCLUDE — eliminating key lookup operations from execution plans
**Viral Angle:** 50x speedup headline + no SQL change required = maximum shareability.

---

### Post 28 — Thursday, 18 Sep 2026

**Hook:**
> Most execution plans are lying to you. Here is the one number you should always look at first.

**Format:** Visual + Code
**Topic:** Reading execution plans — cost percentage, thick arrows (estimated row count), missing index hints
**Viral Angle:** "Your plan is lying" is provocative and immediately actionable.

---

### Post 29 — Friday, 19 Sep 2026

**Hook:**
> MERGE is the most powerful SQL statement most people avoid because it looks scary. It shouldn't.

**Format:** Carousel (5 slides)
**Topic:** MERGE statement — UPSERT pattern for ETL pipelines (WHEN MATCHED / WHEN NOT MATCHED)
**Viral Angle:** MERGE is essential for every ETL engineer. Carousel + UPSERT = highest save rate for this topic.

---

### Post 30 — Saturday, 20 Sep 2026

**Hook:**
> Partition By is not the same as Group By. One shrinks your result set. The other doesn't.

**Format:** Code Snippet + Side-by-Side Output
**Topic:** PARTITION BY (window) vs GROUP BY — the clearest comparison on LinkedIn
**Viral Angle:** This is the most-googled SQL question. Owning this topic = long-term search traffic.

---

## 🔷 PHASE 3: PYTHON FOR DATA ENGINEERING (Sep 21 — Oct 5, 2026) — Posts 31 to 45

---

### Post 31 — Sunday, 21 Sep 2026

**Hook:**
> Python lists load everything into memory. Generators don't. On 50GB files this is the difference between running and crashing.

**Format:** Code Snippet + Memory Comparison
**Topic:** Generators vs lists for large-scale data processing in ETL
**Viral Angle:** Memory efficiency = real production problem. Every data engineer faces this.

---

### Post 32 — Monday, 22 Sep 2026

**Hook:**
> The for loop in Pandas is a code smell. Here's the vectorized alternative that runs 100x faster.

**Format:** Code Snippet + Benchmark
**Topic:** Pandas vectorization vs iterrows() — the performance truth
**Viral Angle:** "100x faster" + working code = one of the highest-save Python posts possible.

---

### Post 33 — Tuesday, 23 Sep 2026

**Hook:**
> Every ETL pipeline that never fails is an ETL pipeline that hasn't processed bad data yet.

**Format:** Text + Code
**Topic:** Defensive ETL design — validation, dead-letter logging, retry logic, schema enforcement
**Viral Angle:** Resonates deeply with every data engineer who has been paged at 2am for a pipeline failure.

---

### Post 34 — Wednesday, 24 Sep 2026

**Hook:**
> Dictionary lookups in Python are O(1). List lookups are O(n). At 10 million records this matters enormously.

**Format:** Code Snippet + Big-O Comparison
**Topic:** Python data structures for DE — Dict, Set, List performance at scale
**Viral Angle:** O(1) vs O(n) at real scale = CS fundamentals applied to practical DE work.

---

### Post 35 — Thursday, 25 Sep 2026

**Hook:**
> Reading a 10GB CSV file in one shot will OOM your server. Reading it in chunks won't. One line of code.

**Format:** Code Snippet
**Topic:** Pandas chunking — processing large files without memory explosion
**Viral Angle:** Extremely practical. One-liner solution. Universal problem.

---

### Post 36 — Friday, 26 Sep 2026

**Hook:**
> An ETL pipeline without retry logic is not production-ready. It's just a script.

**Format:** Code Snippet + Architecture
**Topic:** Retry with exponential backoff — building robust API ingestion in Python
**Viral Angle:** "Production-ready vs script" distinction resonates with senior engineers who are tired of fragile pipelines.

---

### Post 37 — Saturday, 27 Sep 2026

**Hook:**
> OOP is not just for application developers. A class-based ETL pipeline is 10x easier to maintain than a 500-line script.

**Format:** Carousel (6 slides)
**Topic:** OOP pipeline design — Extractor, Transformer, Loader classes for clean DE architecture
**Viral Angle:** Bridging OOP concepts to DE workflow is underrepresented on LinkedIn. High novelty = high engagement.

---

### Post 38 — Sunday, 28 Sep 2026

**Hook:**
> Logging is the most important thing you can add to a data pipeline. Here's the exact logging setup I use.

**Format:** Code Snippet
**Topic:** Python logging for data pipelines — structured logs, file handlers, audit trails
**Viral Angle:** Everyone knows logging matters. Almost no one has a clean implementation. This becomes a template post.

---

### Post 39 — Monday, 29 Sep 2026

**Hook:**
> REST APIs don't always return all records in one call. Pagination is how production APIs really work.

**Format:** Code Snippet + Diagram
**Topic:** API ingestion with pagination — offset/cursor patterns for reliable extraction
**Viral Angle:** Extremely practical. Every person who has ever built an API connector has hit this.

---

### Post 40 — Tuesday, 30 Sep 2026

**Hook:**
> You can build a full data type enforcement layer in Pandas in 10 lines. Most pipelines skip this and regret it.

**Format:** Code Snippet
**Topic:** Schema validation in Pandas — enforcing dtypes, detecting nulls, catching upstream schema drift
**Viral Angle:** Schema drift is the #1 cause of silent pipeline failures. This is a direct solution.

---

### Post 41 — Wednesday, 1 Oct 2026

**Hook:**
> Decorators are not magic. They are functions that wrap other functions. Here's why data engineers need them.

**Format:** Code Snippet + Use Cases
**Topic:** Python decorators for DE — @retry, @timer, @log_execution, @validate_schema
**Viral Angle:** Decorators look scary. Demystifying them = high "aha moment" engagement.

---

### Post 42 — Thursday, 2 Oct 2026

**Hook:**
> NumPy is 50x faster than Python loops for numerical operations. Here's the test.

**Format:** Benchmark + Code Snippet
**Topic:** NumPy vectorized operations vs Python loops for data transformation
**Viral Angle:** Benchmark with actual timings = high credibility and reshare rate.

---

### Post 43 — Friday, 3 Oct 2026

**Hook:**
> Environment variables are not optional in a production pipeline. They are the difference between a safe system and a breach.

**Format:** Text + Code
**Topic:** Secret management in Python pipelines — .env, os.environ, vault patterns, never hardcoding credentials
**Viral Angle:** Security + practical code = reshared by security-conscious teams.

---

### Post 44 — Saturday, 4 Oct 2026

**Hook:**
> Idempotency is the single most important property of an ETL pipeline. Most pipelines don't have it.

**Format:** Carousel (5 slides)
**Topic:** Idempotent pipelines — what it means, why it matters, how to implement it with MERGE and dedup keys
**Viral Angle:** "Most pipelines don't have this" creates urgency. Idempotency is asked in every senior DE interview.

---

### Post 45 — Sunday, 5 Oct 2026

**Hook:**
> Full load vs incremental load is not a preference. It's an architecture decision with long-term consequences.

**Format:** Text + Decision Framework
**Topic:** Full load vs incremental extract patterns — watermark-based, CDC, snapshot comparison
**Viral Angle:** Framework posts with clear decision criteria are highly saved and shared by architects.

---

## 🔷 PHASE 4: ETL ARCHITECTURE & DATA MODELING (Oct 6 — Oct 20, 2026) — Posts 46 to 60

---

### Post 46 — Monday, 6 Oct 2026

**Hook:**
> Bronze, Silver, Gold is not just a naming convention. It is a data quality philosophy.

**Format:** Carousel (6 slides)
**Topic:** Medallion Architecture — Bronze (raw), Silver (validated), Gold (aggregated) explained with real pipeline examples
**Viral Angle:** Medallion architecture is referenced in every lakehouse job description. Ultra-relevant.

---

### Post 47 — Tuesday, 7 Oct 2026

**Hook:**
> Star Schema was invented in 1996. It still outperforms most modern data models in query speed. Here's why.

**Format:** Diagram + Text
**Topic:** Star Schema design — Fact tables, Dimension tables, surrogate keys, denormalization tradeoffs
**Viral Angle:** "30-year-old design still wins" is a surprising claim that generates strong engagement.

---

### Post 48 — Wednesday, 8 Oct 2026

**Hook:**
> SCD Type 2 is the most misunderstood data modeling pattern in analytics. Here's a clear explanation with code.

**Format:** Carousel (6 slides)
**Topic:** Slowly Changing Dimensions — Type 1 (overwrite), Type 2 (history rows), Type 3 (prev column)
**Viral Angle:** SCD is asked in 90% of senior DE and data warehouse interviews. Extremely high search intent.

---

### Post 49 — Thursday, 9 Oct 2026

**Hook:**
> The difference between ETL and ELT is not just 3 letters. It is a completely different engineering philosophy.

**Format:** Text + Comparison Table
**Topic:** ETL vs ELT — when to transform before loading vs transform in the warehouse
**Viral Angle:** Simple distinction with real architectural implications = universally relatable.

---

### Post 50 — Friday, 10 Oct 2026 🏆 MILESTONE POST

**Hook:**
> 50 posts. 50 data engineering concepts. Here is the complete reference map.

**Format:** Long-form Milestone Recap
**Topic:** Posts 1-50 full topic map — organized by category (SQL, Python, Architecture)
**Viral Angle:** Milestone recap posts get reshared across communities. This will generate significant profile traffic.

---

### Post 51 — Saturday, 11 Oct 2026

**Hook:**
> Data quality is not a data science problem. It is a data engineering responsibility.

**Format:** Text + Checklist
**Topic:** Data quality checks every pipeline needs — null rates, schema drift, row count anomalies, dedup validation
**Viral Angle:** "It's your responsibility" framing creates accountability discussion in comments.

---

### Post 52 — Sunday, 12 Oct 2026

**Hook:**
> Surrogate keys are better than natural keys as primary keys in a data warehouse. Here's the 5-reason argument.

**Format:** Numbered List
**Topic:** Surrogate keys vs natural keys — deduplication, performance, join stability, upstream system independence
**Viral Angle:** Definitive list format with strong reasoning = high-save thought leadership post.

---

### Post 53 — Monday, 13 Oct 2026

**Hook:**
> Data pipelines fail in 3 places. Loading is not usually one of them.

**Format:** Story + Root Cause Analysis
**Topic:** Pipeline failure anatomy — extraction failures (source schema), transformation failures (dirty data), loading failures (constraint violations)
**Viral Angle:** "Surprising truth" format drives comments from engineers sharing their own failure stories.

---

### Post 54 — Tuesday, 14 Oct 2026

**Hook:**
> A MERGE statement in SQL is the most efficient way to implement SCD Type 1 and an UPSERT in any data warehouse.

**Format:** Code Snippet + Use Case
**Topic:** MERGE for SCD1 and upsert patterns in production ETL
**Viral Angle:** Practical production code for a universally-needed pattern.

---

### Post 55 — Wednesday, 15 Oct 2026

**Hook:**
> Kimball vs Inmon is not a debate. It's a spectrum. Here's where your data model should actually sit.

**Format:** Carousel (5 slides)
**Topic:** Kimball bottom-up vs Inmon top-down — real-world architectural tradeoffs
**Viral Angle:** "It's not a debate" reframes a famous argument. Strong opinion = strong engagement.

---

## 🔷 PHASE 5: PYSPARK & DISTRIBUTED COMPUTING (Oct 21 — Nov 5, 2026) — Posts 61 to 80

---

### Post 61 — Tuesday, 21 Oct 2026

**Hook:**
> PySpark's lazy evaluation means your code does nothing until you call an action. This is a feature, not a bug.

**Format:** Text + Code + Diagram
**Topic:** Spark lazy evaluation — transformations vs actions, DAG building, execution trigger
**Viral Angle:** Counter-intuitive behavior that every new Spark user misunderstands.

---

### Post 62 — Wednesday, 22 Oct 2026

**Hook:**
> Shuffling in Spark is the performance killer that no one warns you about until production melts.

**Format:** Carousel (6 slides)
**Topic:** Spark shuffle — what causes it, how to minimize it, partition strategies
**Viral Angle:** "No one warns you" framing resonates with engineers who have experienced Spark performance hell.

---

### Post 63 — Thursday, 23 Oct 2026

**Hook:**
> RDD, DataFrame, and Dataset all store distributed data in Spark. They are not the same thing and choosing wrong has consequences.

**Format:** Comparison Table + Code
**Topic:** RDD vs DataFrame vs Dataset — API tradeoffs, type safety, Catalyst optimization availability
**Viral Angle:** Fundamental comparison that every Spark interview covers.

---

### Post 64 — Friday, 24 Oct 2026

**Hook:**
> Broadcast join in Spark can eliminate shuffle entirely for small-large table joins. This is the fastest join Spark can perform.

**Format:** Code Snippet + Diagram
**Topic:** Broadcast Hash Join vs Sort-Merge Join — when to use which and how to force it
**Viral Angle:** Performance optimization with concrete code is highly saved by DE teams.

---

### Post 65 — Saturday, 25 Oct 2026

**Hook:**
> Delta Lake gives your data lake ACID transactions. This was impossible 5 years ago.

**Format:** Carousel (6 slides)
**Topic:** Delta Lake architecture — ACID on object storage, transaction log, time travel, schema enforcement
**Viral Angle:** Delta Lake is the most in-demand lakehouse technology of 2025-2026.

---

### Post 66 — Sunday, 26 Oct 2026

**Hook:**
> Time Travel in Delta Lake is not a marketing term. You can literally query what your table looked like 3 days ago.

**Format:** Code Snippet + Use Case
**Topic:** Delta Lake time travel — VERSION AS OF, TIMESTAMP AS OF, audit recovery scenarios
**Viral Angle:** "Literally query 3 days ago" is a "wow" moment for developers who never knew this was possible.

---

### Post 67 — Monday, 27 Oct 2026

**Hook:**
> The Spark Catalyst Optimizer does 4 things to your query before running it. Most developers skip straight to the execution.

**Format:** Diagram + Text
**Topic:** Catalyst Optimizer — analysis, logical optimization, physical planning, code generation phases
**Viral Angle:** Internals content separates intermediate from advanced engineers in every interview.

---

### Post 68 — Tuesday, 28 Oct 2026

**Hook:**
> Partitioning your Spark data incorrectly can make your job 20x slower than no partitioning at all.

**Format:** Carousel (5 slides)
**Topic:** Spark partitioning strategies — partition by date, hash, range — and the skew problem
**Viral Angle:** "20x slower" is a scary but real headline that drives saves.

---

### Post 69 — Wednesday, 29 Oct 2026

**Hook:**
> Streaming and batch pipelines are converging. Here is why the Lakehouse architecture makes both run on the same engine.

**Format:** Text + Architecture Diagram
**Topic:** Unified batch/streaming on Delta Lake — structured streaming + Delta MERGE for real-time upserts
**Viral Angle:** Unified architecture is the future of data engineering. Forward-looking content drives high engagement.

---

### Post 70 — Thursday, 30 Oct 2026

**Hook:**
> Kafka is not a message queue. It is a distributed commit log. This distinction changes how you design every system around it.

**Format:** Text + Diagram
**Topic:** Kafka architecture — topics, partitions, consumer groups, offset management, retention
**Viral Angle:** Definitional reframing of a widely-used technology = strong engagement from practitioners.

---

## 🔷 PHASE 6: CLOUD, SNOWFLAKE & AIRFLOW (Nov 6 — Nov 20, 2026) — Posts 81 to 100

---

### Post 81 — Friday, 6 Nov 2026

**Hook:**
> Snowflake separates compute from storage. This is not just a feature. It is why the entire cloud data warehouse market changed.

**Format:** Carousel (6 slides)
**Topic:** Snowflake architecture — virtual warehouses, storage layer, compute-storage separation, auto-scaling
**Viral Angle:** Architecture insight behind a universally-known technology = high engagement from practitioners.

---

### Post 82 — Saturday, 7 Nov 2026

**Hook:**
> Micro-partitioning in Snowflake is automatic clustering. Understanding it is the difference between fast queries and expensive ones.

**Format:** Text + Diagram
**Topic:** Snowflake micro-partitions — how data is organized, pruning, cluster keys
**Viral Angle:** Cost optimization + performance in one topic = immediately valuable to every Snowflake team.

---

### Post 83 — Sunday, 8 Nov 2026

**Hook:**
> dbt is not a pipeline tool. It is a transformation layer. Confusing the two costs teams months of rework.

**Format:** Text + Architecture
**Topic:** Where dbt fits in the modern data stack — ELT with dbt, upstream ingestion, downstream BI
**Viral Angle:** Definitive positioning of a widely-debated tool.

---

### Post 84 — Monday, 9 Nov 2026

**Hook:**
> An Apache Airflow DAG that works locally often fails in production. Here are the 5 reasons why.

**Format:** Numbered List + Code
**Topic:** Airflow production gotchas — timezone handling, dynamic DAGs, XCom size limits, sensor timeouts, backfill behavior
**Viral Angle:** "Works locally but fails in prod" is the most relatable developer frustration.

---

### Post 85 — Tuesday, 10 Nov 2026

**Hook:**
> AWS Glue, Azure Data Factory, and Databricks all do ETL. Here's a decision framework for which to use when.

**Format:** Comparison Table + Decision Tree
**Topic:** ETL tool selection framework — Glue vs ADF vs Databricks vs Airbyte for different use cases
**Viral Angle:** Decision frameworks are the most-saved post type among architects and leads.

---

### Post 86 — Wednesday, 11 Nov 2026

**Hook:**
> BigQuery charges by bytes scanned, not by query runtime. This means your SQL style directly impacts your cloud bill.

**Format:** Code Snippet + Cost Comparison
**Topic:** BigQuery cost optimization — column pruning, partitioned tables, clustered tables, avoiding SELECT *
**Viral Angle:** "Your SQL style impacts your bill" creates immediate urgency and utility.

---

### Post 87 — Thursday, 12 Nov 2026

**Hook:**
> The modern data stack in 2026: Fivetran ingests. dbt transforms. Snowflake stores. Airflow orchestrates. Tableau visualizes. Here's how it all connects.

**Format:** Architecture Diagram + Carousel
**Topic:** Modern Data Stack end-to-end — tool by tool, layer by layer
**Viral Angle:** Full-stack architecture diagrams are the most-reshared content in the DE community.

---

### Post 88 — Friday, 13 Nov 2026

**Hook:**
> Data Contracts are the most important concept in data engineering that nobody talks about at the junior level.

**Format:** Text + Framework
**Topic:** Data contracts — upstream/downstream agreements, schema versioning, breaking change protocols
**Viral Angle:** Advanced topic introduced accessibly = "I needed this 2 years ago" comment magnet.

---

### Post 89 — Saturday, 14 Nov 2026

**Hook:**
> Backfilling an Airflow DAG sounds simple. Getting it right without duplicating data requires careful architecture.

**Format:** Code Snippet + Pattern
**Topic:** Idempotent Airflow DAGs for safe backfilling — catchup=True, execution_date parameterization, dedup in target table
**Viral Angle:** Production war story format with a clean solution.

---

### Post 90 — Sunday, 15 Nov 2026 🏆 MILESTONE POST

**Hook:**
> 90 days. 90 posts. 90 data engineering concepts. Here is everything — organized, searchable, and free.

**Format:** Epic Long-Form Recap
**Topic:** Full 90-day #90DaysOfDataEngineering recap — SQL (Posts 1-30), Python/ETL (Posts 31-60), PySpark/Cloud (Posts 61-90)
**Viral Angle:** 90-day recap posts generate massive retroactive engagement across all previous posts and new followers.

---

## 🔷 PHASE 7: DE INTERVIEW DOMINATION (Nov 16 — Dec 5, 2026) — Posts 91 to 110

---

### Post 91 — Monday, 16 Nov 2026

**Hook:**
> "Write a query to find the second highest salary." This is asked in every SQL interview. Here are 4 ways to solve it — and which one actually impresses.

**Format:** Code Snippet (4 solutions compared)
**Topic:** Second highest salary — subquery, DENSE_RANK, OFFSET-FETCH, correlated subquery approaches
**Viral Angle:** Universal interview question + multiple solutions + "which impresses" = extremely high save rate.

---

### Post 92 — Tuesday, 17 Nov 2026

**Hook:**
> "Tell me about a time your pipeline failed." Every DE interview asks this. Most candidates freeze. Here's the STAR answer framework for it.

**Format:** Story + Framework
**Topic:** Behavioral interview prep for data engineers — STAR method applied to pipeline failures, data quality incidents
**Viral Angle:** Immediately actionable interview prep for a universally difficult question.

---

### Post 93 — Wednesday, 18 Nov 2026

**Hook:**
> System design for data engineers: Design a real-time fraud detection pipeline for 1 million transactions per second.

**Format:** Architecture Diagram + Step-by-Step
**Topic:** Real-time streaming system design — Kafka ingestion, Flink processing, feature engineering, Delta Lake storage, alerting
**Viral Angle:** System design questions are the #1 fear in Tier-1 DE interviews.

---

### Post 94 — Thursday, 19 Nov 2026

**Hook:**
> Top 10 SQL questions asked at Goldman Sachs, Barclays, and JPMorgan Data Engineering interviews. With answers.

**Format:** Long-form Q&A List
**Topic:** FinTech SQL interview questions — window functions, transaction isolation, ACID, execution plans
**Viral Angle:** Company-specific interview question posts always trend strongly in the DE community.

---

### Post 95 — Friday, 20 Nov 2026

**Hook:**
> "What is the difference between a Data Engineer and a Data Scientist?" Most people answer this wrong in interviews.

**Format:** Comparison + Career Insight
**Topic:** DE vs DS vs DA — roles, responsibilities, skill overlaps, the boundary that Tier-1 companies care about
**Viral Angle:** Career positioning is universally discussed and universally misunderstood.

---

### Post 96 — Saturday, 21 Nov 2026

**Hook:**
> The Snowflake interview question that trips up 80% of candidates: "What happens when you run out of virtual warehouse credits mid-query?"

**Format:** Technical Q&A + Deep Dive
**Topic:** Snowflake credit management, query queuing, multi-cluster warehouses, auto-suspend behavior
**Viral Angle:** Specific, surprising, technical — exactly the format that gets reshared by people who "want to remember this."

---

### Post 97 — Sunday, 22 Nov 2026

**Hook:**
> "Design a data pipeline that runs nightly but cannot afford to skip a day." Here's the architecture.

**Format:** System Design + Architecture Diagram
**Topic:** Fault-tolerant batch pipeline design — Airflow scheduling, failure alerts, retry policies, dead-letter handling, SLA monitoring
**Viral Angle:** Real-world constraint-based design problems generate strong discussion.

---

### Post 98 — Monday, 23 Nov 2026

**Hook:**
> PySpark interview question: "Your job takes 3 hours. How do you make it run in 45 minutes?" Systematic answer.

**Format:** Numbered Optimization Framework
**Topic:** Spark performance tuning checklist — partition count, broadcast joins, caching, skew handling, Kryo serialization
**Viral Angle:** Concrete performance improvement framework = one of the highest-save Spark posts.

---

### Post 99 — Tuesday, 24 Nov 2026

**Hook:**
> "Walk me through your best data engineering project." Most candidates describe what they built. The best candidates describe why decisions were made.

**Format:** Story + Framework
**Topic:** How to present DE projects in interviews — problem, constraints, tradeoffs, architecture decisions, measurable outcomes
**Viral Angle:** Interview coaching for the most important and most fumbled interview question.

---

### Post 100 — Wednesday, 25 Nov 2026 🏆 MEGA MILESTONE POST

**Hook:**
> 100 posts in. Here's what 100 data engineering concepts look like when mapped to a career path.

**Format:** Epic Milestone + Full Career Roadmap Graphic
**Topic:** 100-post milestone + DE career skill map from junior to principal
**Viral Angle:** 100-post milestones are extremely rare and always generate outsized engagement. This is the biggest organic growth trigger.

---

## 🔷 PHASE 8: ADVANCED TOPICS & THOUGHT LEADERSHIP (Nov 26 — Dec 31, 2026) — Posts 101 to 150

Posts 101-150 continue with advanced themes:
- Apache Iceberg and table formats
- dbt advanced patterns (macros, packages, exposures)
- Data observability and monitoring (Monte Carlo, Great Expectations)
- Cost optimization on cloud platforms
- Data mesh architecture principles
- ML feature engineering pipelines
- Real-time vs near-real-time architectural tradeoffs
- Kafka Connect and schema registry
- Infrastructure as Code for data platforms (Terraform)
- GitHub Actions for CI/CD data pipelines

---

## 🔷 PHASE 9: PERSONAL BRAND AUTHORITY & COMMUNITY (Jan 1 — Feb 20, 2027) — Posts 151 to 200

Posts 151-200 include:
- Weekly "Data Engineering Problem of the Week" (community interactive posts)
- Case study deep dives (real pipeline architectures at Snowflake, Uber, Airbnb)
- Technical comparison posts (Airflow vs Prefect vs Dagster)
- "What I wish I knew 2 years ago" retrospective posts
- 200-post capstone: "200 DE concepts — the complete knowledge base"

---

## 📌 QUICK REFERENCE TABLE — First 30 Posts

| # | Date | Topic | Format | Viral Angle |
| :---: | :--- | :--- | :--- | :--- |
| 1 | 22 Aug | SQL JOIN internals — Nested Loop, Hash Match, Merge | Text | "What actually happens inside" |
| 2 | 23 Aug | NULL trap in NOT IN vs LEFT JOIN anti-join | Code | "This cost me 3 hours" |
| 3 | 24 Aug | Self Join — when a table joins itself | Carousel | Mirror analogy, elegant pattern |
| 4 | 25 Aug | TRUNCATE vs DELETE — the physical difference | Text | Myth-busting rollback claim |
| 5 | 26 Aug | ROW_NUMBER vs RANK vs DENSE_RANK | Code | Most-saved SQL topic |
| 6 | 27 Aug | LEAD and LAG — time-series without self-joins | Code | Immediately applicable |
| 7 | 28 Aug | CROSS JOIN — when it explodes and when it's useful | Text | "Can destroy your server" hook |
| 8 | 29 Aug | Recursive CTEs for hierarchical data | Carousel | Universal use case |
| 9 | 30 Aug | PK vs UNIQUE — 4 critical differences | Text | Misconception correction |
| 10 | 31 Aug | IDENTITY gaps — what actually happens | Code | "Assumed it works — it doesn't" |
| 11 | 1 Sep | FK as query optimizer hint | Text | "Not just what you think" |
| 12 | 2 Sep | #temp vs @var vs CTE decision framework | Carousel | Highest-save DE format |
| 13 | 3 Sep | DATEDIFF boundary-crossing silent bug | Code | Silent bug exposure |
| 14 | 4 Sep | ORDER BY in subquery is meaningless | Text | Counterintuitive truth |
| 15 | 5 Sep | SQL logical execution order | Visual List | Most-pinned SQL graphic |
| 16 | 6 Sep | Clustered index IS the table | Carousel | Mind-shift statement |
| 17 | 7 Sep | 10M row query timeout — diagnostic playbook | Story | Practical troubleshooting |
| 18 | 8 Sep | CHECK constraints — free database validation | Code | "Stop doing X" pattern |
| 19 | 9 Sep | SARGable vs Non-SARGable predicates | Benchmark | Concrete numbers |
| 20 | 10 Sep | ROLLUP and CUBE for analytics | Carousel | "I didn't know this existed" |
| 21 | 11 Sep | ACID — each property can break | Text | "Can break" urgency |
| 22 | 12 Sep | Transaction isolation levels | Carousel | Most misunderstood SQL setting |
| 23 | 13 Sep | Deadlock anatomy + prevention | Story | Real debugging story format |
| 24 | 14 Sep | Correlated vs non-correlated subquery | Code | Performance cliff comparison |
| 25 | 15 Sep | 25-post SQL cheatsheet | Long List | Most-saved format on LinkedIn |
| 26 | 16 Sep | INTERSECT vs INNER JOIN — NULL difference | Code | "Wait, really?" moment |
| 27 | 17 Sep | Covering indexes — 50x without SQL changes | Benchmark | Extreme speedup headline |
| 28 | 18 Sep | Reading execution plans | Visual | "Your plan is lying" hook |
| 29 | 19 Sep | MERGE / UPSERT patterns | Carousel | Most-saved ETL pattern |
| 30 | 20 Sep | PARTITION BY vs GROUP BY | Code | Most-googled SQL question |

---

## 📝 DAILY POSTING CHECKLIST

Before publishing each post:
- [ ] Hook line creates a knowledge gap or challenges a common assumption
- [ ] First 2 lines work without clicking "See More" — they must earn the click
- [ ] At least 1 code block or comparison table included
- [ ] Key Takeaway line at the bottom — this is the quote that gets reshared
- [ ] 8-12 hashtags: mix of broad (#DataEngineering) + specific (#SelfJoin) + campaign (#90DaysOfDataEngineering)
- [ ] Voice is experienced practitioner — NOT "I just learned", NOT course-student framing
- [ ] Post is published between 8-9 AM or 7-9 PM IST (peak LinkedIn algorithm windows)

---

*"200 posts is 200 proof-of-works. Each one tells the world: I know what I'm doing, and I show up every day."*
*— Pippo 🐥*
