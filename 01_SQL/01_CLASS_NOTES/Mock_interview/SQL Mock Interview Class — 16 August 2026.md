# 🎯 SQL MOCK INTERVIEW CLASS

**📅 Date:** 16 August 2026  
**🎯 Focus:** SQL Interview Preparation  
**⏱️ Approach:** Quick • Clear • Correct • Confident

---

## 🧠 INTERVIEW RULE

> **Don't give the longest answer. Give the best answer in the shortest possible time.**

### Answer Formula:
**Definition → Key Point → Example (if needed) → STOP**

---

## 📚 TOPICS TO COVER

### 1. SQL
**Interview Answer:**

> SQL stands for Structured Query Language. It is used to communicate with and manage data in relational databases.

---

### 2. PRIMARY KEY
**Interview Answer:**

> A primary key uniquely identifies each record in a table. It does not allow duplicate or NULL values.

---

### 3. DISTINCT
**Interview Answer:**

> DISTINCT is used to remove duplicate values and return only unique values.

---

### 4. DEFAULT
**Interview Answer:**

> DEFAULT automatically assigns a predefined value to a column when no value is provided during insertion.

---

### 5. AGGREGATE FUNCTION
**Interview Answer:**

> An aggregate function performs calculations on multiple rows and returns a single result. Examples are COUNT, SUM, AVG, MAX, and MIN.

---

### 6. GROUP BY
**Interview Answer:**

> GROUP BY is used to group rows having the same values, usually for performing aggregate calculations on each group.

---

### 7. ORDER BY
**Interview Answer:**

> ORDER BY is used to sort the result set in ascending or descending order.

---

### 8. GROUP BY vs ORDER BY

> GROUP BY groups similar records for aggregation, while ORDER BY sorts the final result.

**Memory:**

> **GROUP = Group data**  
> **ORDER = Sort data**

---

### 9. GROUP BY WITHOUT AGGREGATE

> GROUP BY can be used without an aggregate function. In that case, it returns one row for each unique group.

Example:

```sql
SELECT dept
FROM emp
GROUP BY dept;
```

---

## 🧮 SQL COMMAND TYPES

### DDL — Data Definition Language
`CREATE` • `ALTER` • `DROP` • `TRUNCATE`

### DML — Data Manipulation Language
`INSERT` • `UPDATE` • `DELETE`

### DQL — Data Query Language
`SELECT`

### DCL — Data Control Language
`GRANT` • `REVOKE`

### TCL — Transaction Control Language
`COMMIT` • `ROLLBACK` • `SAVEPOINT`

**Interview Answer:**

> SQL commands are generally classified into five categories: DDL, DML, DQL, DCL, and TCL.

---

# 💻 QUERY PRACTICE

## Q1. Highest salary given to a manager in each department

```sql
SELECT dept, MAX(salary) AS highest_salary
FROM emp
WHERE job = 'MANAGER'
GROUP BY dept;
```

**Logic:**  
Filter managers → Group by department → Find maximum salary.

---

## Q2. Number of employees getting commission in each department

```sql
SELECT dept, COUNT(empid) AS number_of_employees
FROM emp
WHERE commission IS NOT NULL
GROUP BY dept;
```

**Logic:**  
Filter commission employees → Group by department → Count employees.

---

## Q3. Number of employees getting salary greater than 1600, excluding managers, in each department

```sql
SELECT dept, COUNT(empid) AS number_of_employees
FROM emp
WHERE salary > 1600
AND job <> 'MANAGER'
GROUP BY dept;
```

**Logic:**  
Salary condition → Exclude managers → Group by department → Count.

---

## Q4. Salaries repeated in the EMP table

```sql
SELECT salary, COUNT(*) AS repeated_count
FROM emp
GROUP BY salary
HAVING COUNT(*) > 1;
```

**Logic:**  
Group same salaries → Count occurrences → Show only repeated salaries.

---

# 🔥 QUICK INTERVIEW MEMORY

### WHERE vs HAVING

**WHERE** → filters individual rows **before grouping**

**HAVING** → filters groups **after grouping**

---

### COUNT vs MAX

**COUNT()** → How many?

**MAX()** → Highest?

---

### DISTINCT vs GROUP BY

**DISTINCT** → Unique values

**GROUP BY** → Groups values, usually for aggregation

---

### GROUP BY vs ORDER BY

**GROUP BY** → Group

**ORDER BY** → Sort

---

# 🎤 MOCK INTERVIEW STYLE

For every question:

**Interviewer:** What is an aggregate function?

**You:**

> “An aggregate function performs calculations on multiple rows and returns a single result, such as COUNT, SUM, AVG, MAX, and MIN.”

**STOP.**

Don't add extra information unless the interviewer asks.

---

# 🏆 CLASS OBJECTIVE

By the end of the mock interview, the target is:

**✅ Understand the concept**  
**✅ Give the answer quickly**  
**✅ Write the correct query**  
**✅ Explain the query logically**  
**✅ Avoid unnecessary explanation**  
**✅ Stay calm and confident**

> **QUALITY OF ANSWER > LENGTH OF ANSWER**

### 🎯 Final Rule

**Think → Answer → Explain briefly → Stop.**

No guessing.  
No unnecessary talking.  
No memorized paragraphs.

**Correct. Clear. Quick. Confident.**