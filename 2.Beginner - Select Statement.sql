-- Beginner Lesson: SELECT Statement
-- Source: Alex The Analyst YouTube MySQL Series
-- Customized by Mubasshir Ahmed (Date: 22 June 2025)
-- Description: Demonstrates basic SELECT syntax, selecting all columns,
--              specific columns, ordering columns, performing calculations,
--              respecting PEMDAS, and using DISTINCT to remove duplicates.
-- Prerequisite: Database `Parks_and_Recreation` with tables:
--               employee_demographics, employee_salary, parks_departments

/* -------------------------------------------------------------------------
   0. Set the working database
   ------------------------------------------------------------------------- */
USE Parks_and_Recreation;

/* -------------------------------------------------------------------------
   1. Select All Columns
   ------------------------------------------------------------------------- */

SELECT *
FROM employee_demographics;

/* -------------------------------------------------------------------------
   2. Select Specific Columns
   ------------------------------------------------------------------------- */

-- Single column
SELECT first_name
FROM employee_demographics;

-- Multiple columns
SELECT first_name,
       last_name
FROM employee_demographics;

-- Multiple columns (different order)
SELECT last_name,
       first_name,
       gender,
       age
FROM employee_demographics;

/* -------------------------------------------------------------------------
   3. Readable Formatting Example
   ------------------------------------------------------------------------- */

SELECT last_name,
       first_name,
       gender,
       age
FROM employee_demographics;

/* -------------------------------------------------------------------------
   4. Column Arithmetic & PEMDAS
   ------------------------------------------------------------------------- */

-- Example 1: salary + 100 (Addition happens after retrieving the salary value)
SELECT first_name,
       last_name,
       salary,
       salary + 100               AS salary_plus_100
FROM employee_salary;

-- Example 2: (salary + 100) * 10 (Addition inside parentheses happens first,
--            then multiplication by 10 — demonstrating PEMDAS)
SELECT first_name,
       last_name,
       salary,
       (salary + 100) * 10        AS salary_plus100_times10
FROM employee_salary;

/* -------------------------------------------------------------------------
   5. DISTINCT Values
   ------------------------------------------------------------------------- */

-- All department IDs (may include duplicates)
SELECT * from employee_salary;

SELECT dept_id
FROM employee_salary;

-- Unique department IDs only
SELECT DISTINCT dept_id
FROM employee_salary;

