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
6. **Index-Wise Questions Format**: All practice question files in `05_INDEX_WISE_QUESTIONS/` must follow a high-yield, 6-question / 24-subquestion vertical stack layout:
   - Target exactly **6 main questions** per file, with each main question containing **4 detailed subquestions** (representing exactly **24 subquestions** in total per file).
   - Keep comments and descriptions extremely narrow (wrap to a tight vertical stack, e.g., max 45-50 characters wide) to fit side-by-side edit layouts in SSMS.
   - Enclose questions in clean comment blocks with blank lines below `-- Write your SQL Query below:`.
   - The 6 questions must cover:
     * **Question 1: Basic Syntax Drills** (4 subquestions focusing on core command structure).
     * **Question 2: Operator & Filtering Checks** (4 subquestions on WHERE, comparisons, and list checks).
     * **Question 3: Cumulative Revision** (4 subquestions testing prior days' topics).
     * **Question 4: Enterprise Scenario Challenge A** (4 progressive subquestions building an advanced query).
     * **Question 5: Enterprise Scenario Challenge B** (4 progressive subquestions building a second advanced query).
     * **Question 6: Logic Builder & Debugging** (4 subquestions targeting query analysis and error correction).
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
