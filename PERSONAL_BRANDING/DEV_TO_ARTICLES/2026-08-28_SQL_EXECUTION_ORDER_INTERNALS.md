# 📝 DEV.TO ARTICLE #01 (28 AUG 2026)

- **Platform:** [Dev.to](https://dev.to/arpitmbangre)
- **Author:** Arpit Manoj Bangre
- **Category:** SQL Internals & Query Architecture
- **Status:** Published ✅
- **Canonical URL:** `https://dev.to/arpitmbangre/sql-execution-order-internals-why-where-fails-on-aliases-but-order-by-succeeds`

---

## 🏷️ METADATA & TAGS
- **Title:** `SQL Execution Order Internals: Why WHERE Fails on Aliases but ORDER BY Succeeds`
- **Tags:** `sql`, `database`, `dataengineering`, `backend`

---

## 📄 FULL READY-TO-COPY MARKDOWN BODY

```markdown
Ever wondered why this query fails in SQL?

```sql
SELECT department_id, COUNT(*) AS emp_count
FROM employees
WHERE emp_count > 5 -- ❌ Error: Invalid column name 'emp_count'
GROUP BY department_id;
```

### The 6-Stage Execution Engine:
1. `FROM` & `JOIN` (Load source tables & evaluate join conditions)
2. `WHERE` (Filter raw rows before grouping)
3. `GROUP BY` (Aggregate rows into buckets)
4. `HAVING` (Filter aggregated buckets)
5. `SELECT` (Compute column expressions & column aliases)
6. `ORDER BY` (Sort final output)

### Why It Fails:
Because `WHERE` executes at **Stage 2**, the `emp_count` alias created at **Stage 5 (SELECT)** does not exist in memory yet! 

However, `ORDER BY` runs at **Stage 6 (after SELECT)**, which is why `ORDER BY emp_count DESC` works seamlessly.

### How to Fix:
Use `HAVING` for aggregated filtering:
```sql
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;
```

---
💡 *What's your favorite SQL execution order quirk? Drop your thoughts below!*  
🌐 *Portfolio:* [arpitbangre.vercel.app](https://arpitbangre.vercel.app/)
```
