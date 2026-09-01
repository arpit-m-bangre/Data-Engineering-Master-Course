# 🎬 210-DAY CREATOR ENGINE — DAY 002 REEL / SHORT
### 📌 Title: The 50% Order Drop Trap: Why LEAD() Needs an Anchor

- **Day #:** Day 002 / 210
- **Date:** 01 September 2026 (Tuesday)
- **Format:** 🎬 Reel / YouTube Short (30–45s Vertical Video)
- **Target Platforms:** Instagram Reels, YouTube Shorts, LinkedIn Video

---

## 🎙️ 1. 30-SECOND READY-TO-SPEAK VOICE SCRIPT

> **[0–5s HOOK - Pattern Interrupt]:**  
> *"If you write `LEAD()` like this in a Tier-1 Data Engineering SQL round, you fail immediately..."*

> **[5–15s THE TRAP - Rookie Code]:**  
> *"Say the interviewer asks: 'Find customers whose 2nd order was 50% less than their 1st order.'  
> Most people just write `LEAD(amount) OVER (PARTITION BY customer_id ORDER BY order_date)`.  
> But wait! That compares Order 1 to 2, Order 2 to 3, AND Order 3 to 4!"*

> **[15–30s THE SENIOR FIX - The Anchor]:**  
> *"To fix this, you MUST anchor your calculation with `ROW_NUMBER()`.  
> Filter `WHERE OrderNumber = 1` inside a CTE so you ONLY compare the 1st and 2nd orders.  
> Boom — clean, production-grade SQL that crushes the interview."*

> **[30–35s CALL TO ACTION]:**  
> *"Save this reel for your next SQL interview! Day 2 of 210 Days of Data Engineering 🚀"*

---

## 💻 2. SCREEN CODE SNIPPET (Show on Dark Mode SSMS / VS Code)

```sql
WITH CustomerOrders AS (
    SELECT 
        customer_id,
        order_date,
        amount AS first_order_amount,
        LEAD(amount, 1) OVER (PARTITION BY customer_id ORDER BY order_date) AS second_order_amount,
        ROW_NUMBER()    OVER (PARTITION BY customer_id ORDER BY order_date) AS order_num
    FROM Orders
)
SELECT 
    customer_id,
    first_order_amount,
    second_order_amount
FROM CustomerOrders
WHERE order_num = 1 
  AND second_order_amount <= (first_order_amount * 0.50);
```

---

## 📝 3. COPY-PASTE CAPTION & HASHTAGS (Instagram / Shorts / LinkedIn)

```text
Ever fallen into the LEAD() window function trap in SQL? ⚠️👇

When calculating period-over-period drops (like comparing a customer's 1st order vs 2nd order), standard LEAD() evaluates EVERY consecutive row pair across the entire partition.

To isolate the 1st and 2nd transactions cleanly, always anchor with ROW_NUMBER() = 1 inside a CTE!

Day 002 of #210DaysOfDataEngineering 🚀
Save this for your upcoming Data Engineering interview prep! 💾

#DataEngineering #SQL #SQLServer #DatabaseInternals #WindowFunctions #PySpark #BigData #LeetCodeSQL #SoftwareEngineering #TechCareer
```
