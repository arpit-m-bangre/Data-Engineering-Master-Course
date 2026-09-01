/* ====================================================================================================
   🎓 SQL CLASS NOTES - 01 SEPTEMBER 2026 (DAY 24)
   🏢 MODULE 01: SQL Relational Architecture & Query Engine
   🎯 TOPIC: T-SQL Server Functions — String Transformations, Slicing, Masking & Cleansing Engine
   ==================================================================================================== */

-- ====================================================================================================
-- ⚙️ SECTION 1: SETUP DEMO TABLES & SEED DATA
-- ====================================================================================================

IF OBJECT_ID('StudentDumy', 'U') IS NOT NULL DROP TABLE StudentDumy;
IF OBJECT_ID('StudentInfo', 'U') IS NOT NULL DROP TABLE StudentInfo;
IF OBJECT_ID('T1', 'U') IS NOT NULL DROP TABLE T1;

CREATE TABLE StudentDumy
(
    ID   INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

INSERT INTO StudentDumy (Name) VALUES
('amit'),
('abhijeet'),
('rohan'),
('pooja');

CREATE TABLE StudentInfo
(
    StudentID   INT IDENTITY(101,1) PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    Subject     VARCHAR(50) NOT NULL,
    City        VARCHAR(50) NOT NULL
);

INSERT INTO StudentInfo (StudentName, Subject, City) VALUES
('Amit', 'Data Engineering', 'Pune'),
('Abhijeet', 'Cloud Computing', 'Mumbai'),
('Rohan', 'Machine Learning', 'Bangalore'),
('Pooja', 'Database Management', 'Hyderabad');


-- ====================================================================================================
-- ⚙️ SECTION 2: CASE CONVERSION FUNCTIONS (UPPER & LOWER)
-- ====================================================================================================

/* Theory: UPPER() and LOWER() convert character strings. In a SELECT projection, the change is temporary.
   To make modifications permanent on disk, an UPDATE statement is executed. */

-- 1. Temporary Case Transformation (SELECT Projection)
SELECT Name, UPPER(Name) AS UpperName, LOWER(Name) AS LowerName
FROM StudentDumy;

-- 2. Permanent Case Mutation (DML UPDATE)
UPDATE StudentDumy
SET Name = UPPER(Name);

-- Verify Permanent Change
SELECT * FROM StudentDumy;

-- Revert back to Lowercase permanently
UPDATE StudentDumy
SET Name = LOWER(Name);

-- 3. Case-Sensitivity in CHECK Constraints & SSMS Collation Trap
/* Theory: In default case-insensitive collations (SQL_Latin1_General_CP1_CI_AS), 
   CHECK (Name = UPPER(Name)) evaluates true regardless of case. Triggers or binary collation enforce strict case. */
CREATE TABLE T1
(
    ID   INT,
    Name VARCHAR(10) CHECK (Name = UPPER(Name) COLLATE Latin1_General_BIN)
);

INSERT INTO T1 VALUES (1, 'ABC'); -- Succeeds in binary check
-- INSERT INTO T1 VALUES (2, 'abc'); /* Error: ❌ Fails binary check constraint */


-- ====================================================================================================
-- ⚙️ SECTION 3: STRING MEASUREMENT & MANIPULATION (LEN, REVERSE, REPLACE, REPLICATE)
-- ====================================================================================================

/* Theory: LEN() returns character count. It counts leading and middle spaces but ignores trailing spaces.
   DATALENGTH() counts total raw storage bytes including trailing spaces. */
SELECT 
    Name, 
    LEN(Name) AS CharLength,
    REVERSE(Name) AS ReversedName
FROM StudentDumy;

-- 4. REPLACE(string, old_pattern, new_pattern)
SELECT 
    Name, 
    REPLACE(Name, 'a', '123') AS ReplacedA,
    REPLACE(REPLACE(Name, 'a', '123'), '123', 'a') AS RevertedPattern
FROM StudentDumy;

-- 5. REPLICATE(string, count)
SELECT 
    Name, 
    REPLICATE(Name, 4) AS RepeatedName
FROM StudentDumy;


-- ====================================================================================================
-- ⚙️ SECTION 4: CONCATENATION & STRING SLICING (CONCAT & SUBSTRING)
-- ====================================================================================================

/* Theory: Traditional '+' operator fails when concatenating incompatible data types without explicit CAST,
   or yields NULL if any operand is NULL. CONCAT() automatically handles type conversions and treats NULLs as empty strings. */

-- 6. String Concatenation: '+' vs CONCAT()
SELECT StudentName + ' ' + Subject AS PlusConcat 
FROM StudentInfo;

SELECT CONCAT(StudentName, '      ', Subject) AS NullSafeConcat 
FROM StudentInfo;

-- 7. SUBSTRING(expression, start_position, length)
/* Theory: SQL Server uses 1-based indexing. Start position 1 refers to the first character. */
SELECT 
    Name,
    SUBSTRING(Name, 1, 2) AS FirstTwoChars,
    SUBSTRING(REVERSE(Name), 1, 1) AS LastChar
FROM StudentDumy;


-- ====================================================================================================
-- ⚙️ SECTION 5: COMPOSITE IN-CLASS SCENARIO DRILLS
-- ====================================================================================================

-- 1. Format: StudentName(FirstLetterOfCity) -> Example: Amit(p)
SELECT 
    StudentName,
    City,
    CONCAT(StudentName, '(', LOWER(SUBSTRING(City, 1, 1)), ')') AS FormattedName
FROM StudentInfo;

-- 2. Dynamic Password Generator: First 4 chars + '_' + Month + Day -> abhijeet -> abhi_0901
SELECT 
    Name,
    CONCAT(
        SUBSTRING(Name, 1, 4), 
        '_', 
        RIGHT('0' + CAST(DATEPART(MONTH, GETDATE()) AS VARCHAR(2)), 2),
        RIGHT('0' + CAST(DATEPART(DAY, GETDATE()) AS VARCHAR(2)), 2)
    ) AS GeneratedPassword
FROM StudentDumy;

/* Faculty Homework: see 04_CLASS_TASKS/2026-09-01_CLASS_TASK.SQL */
