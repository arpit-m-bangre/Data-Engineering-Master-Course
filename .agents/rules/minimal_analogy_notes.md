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
6. **Index-Wise Questions Format**: All practice question files in `05_INDEX_WISE_QUESTIONS/` must follow a high-yield, 14-question Hybrid structure:
   - Target exactly **14 questions** per file (to balance deep logic building and time management).
   - Enclose questions in clean comment blocks with blank lines below `-- Write your SQL Query below:`.
   - Divide each file into 4 distinct phases:
     * **Phase 1: Basic Syntax Drills (Q1 - Q4)**: Quick syntax validation on new topics.
     * **Phase 2: Cumulative Revision (Q5 - Q8)**: Re-enforcing key concepts from previous classes.
     * **Phase 3: Enterprise Scenario Challenges (Q9 - Q12)**: Complex real-world data engineering scenarios.
     * **Phase 4: Logic Builder & Debugging (Q13 - Q14)**: SQL optimization and fixing broken queries.
7. **Class Notes Dividers & Spacing Style**:
   - Use double equal-sign blocks for major sections:
     ```sql
     /*================================================================
     1. SECTION NAME
     ==================================================================*/
     ```
   - Use single hyphen-sign blocks for query execution flow, tips, or notes:
     ```sql
     /*----------------------------------------------------------------
     Sequence of Execution
     ------------------------------------------------------------------*/
     ```
   - Keep generous vertical spacing (empty lines) between queries, comments, and blocks.
   - Keep explanations minimal, straight-to-the-point, and placed directly below the relevant SQL code.
