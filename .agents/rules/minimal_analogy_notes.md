# Minimal & Analogy-Driven SQL Notes Rule

## Core Directives
1. **Analogy-First Explanations**: When documenting database concepts, prioritize short, real-world analogies:
   - *DELETE vs TRUNCATE vs DROP*: Spiral notebook (Eraser vs Page Ripping vs Demolition).
   - *PRIMARY KEY (PK)*: The ultimate ID card (Unique + NOT NULL).
   - *UNIQUE*: Duplicate checker (Unique, allows exactly 1 NULL in SQL Server).
   - *IDENTITY*: Bank ticket dispenser (auto-increments integers).
   - *FOREIGN KEY (FK)*: Child holding parent's hand (Custid must exist in PKID).
   - *WHERE vs HAVING*: Club bouncer filtering rows vs Table manager filtering groups.
2. **Comment Layout Flow**: Always place the SQL query *first* (either active or commented out), followed immediately by the success/failure description *below* it.
   - Example:
     ```sql
     -- ALTER TABLE q10 ADD CONSTRAINT pk011 PRIMARY KEY (id);
     -- ❌ Fails: Cannot define PRIMARY KEY constraint on nullable column 'id'.
     ```
3. **Screen Fitting & Spacing**: Wrap all comments vertically (keep lines under 80 characters) so they fit comfortably on standard screens without horizontal scrolling. Use clean, open vertical spacing between blocks.
4. **Keyword Uppercase**: Keep all SQL query keywords in UPPERCASE syntax.
5. **Zero Data Loss**: Never delete, mask, or alter actual SQL query code blocks, sample insert statements, or data values.
6. **Index-Wise Questions Format**: All practice question files in `05_INDEX_WISE_QUESTIONS/` must follow a structured, multi-level layout:
   - Divided into progressive levels (e.g. Level 1 - Basic, Level 2 - Intermediate, etc.) focusing on syntax and specific operations.
   - Include real-world scenario-based questions (keep actual practical contexts like sales, products, etc.).
   - Include a **Challenge Questions** section for complex edge cases.
   - Include a **Bonus Theory (Interview)** section for conceptual verification.
   - All questions must have blank lines below `-- Write your SQL Query below:` so they can be solved from scratch.
