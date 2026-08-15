# Minimal & Analogy-Driven SQL Notes Rule

## Core Directives
1. **Analogy-First Explanations**: When documenting database concepts, prioritize short, real-world analogies:
   - *DELETE vs TRUNCATE vs DROP*: Spiral notebook (Eraser vs Page Ripping vs Demolition).
   - *PRIMARY KEY (PK)*: The ultimate ID card (Unique + NOT NULL).
   - *UNIQUE*: Duplicate checker (Unique, allows exactly 1 NULL in SQL Server).
   - *IDENTITY*: Bank ticket dispenser (auto-increments integers).
   - *FOREIGN KEY (FK)*: Child holding parent's hand (Custid must exist in PKID).
   - *WHERE vs HAVING*: Club bouncer filtering rows vs Table manager filtering groups.
2. **Minimal Wording**: Keep explanations short, punchy, and bullet-pointed. Eliminate wordy descriptions.
3. **Keyword Uppercase**: Keep all SQL query keywords in UPPERCASE syntax.
4. **Zero Data Loss**: Never delete, mask, or alter actual SQL query code blocks, sample insert statements, or data values.
