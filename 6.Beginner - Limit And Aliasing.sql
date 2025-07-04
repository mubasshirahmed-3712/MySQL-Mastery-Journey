-- Beginner Lesson: LIMIT and ALIASING
-- Source: Alex The Analyst YouTube MySQL Series
-- Customized by Mubasshir Ahmed (Date: 22 June 2025)
-- Description: Demonstrates the use of LIMIT to restrict output and ALIASING to rename columns.
-- Prerequisite: Database `Parks_and_Recreation` with table: employee_demographics

/* -------------------------------------------------------------------------
   0. Set the working database
   ------------------------------------------------------------------------- */
USE Parks_and_Recreation;

/* -------------------------------------------------------------------------
   1. LIMIT Clause
   ------------------------------------------------------------------------- */

-- Limit output to first 3 rows
SELECT *
FROM employee_demographics
LIMIT 3;

-- Limit with ordering: first 3 alphabetically by first_name
SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3;

-- LIMIT with offset: Start at 4th record (index 3), return 2 rows
SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3, 2;

-- Example use case: select 3rd oldest person by age
SELECT *
FROM employee_demographics
ORDER BY age DESC;

-- Target the 3rd record (index 2) in descending age
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

/* -------------------------------------------------------------------------
   2. ALIASING Columns
   ------------------------------------------------------------------------- */

-- Average age by gender (without alias)
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

-- Using AS to name the column
SELECT gender, AVG(age) AS Avg_age
FROM employee_demographics
GROUP BY gender
HAVING Avg_age > 40;

-- Alias without AS (still valid, less explicit)
SELECT gender, AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender;
