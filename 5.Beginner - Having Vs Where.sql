-- Beginner Lesson: HAVING vs WHERE Clause
-- Source: Alex The Analyst YouTube MySQL Series
-- Customized by Mubasshir Ahmed (Date: 22 June 2025)
-- Description: Demonstrates the difference between WHERE and HAVING in SQL,
--              especially when using aggregate functions with GROUP BY.
-- Prerequisite: Database `Parks_and_Recreation` with tables:
--               employee_demographics, employee_salary

/* -------------------------------------------------------------------------
   0. Set the working database
   ------------------------------------------------------------------------- */
USE Parks_and_Recreation;

/* -------------------------------------------------------------------------
   1. Basic GROUP BY with Aggregation
   ------------------------------------------------------------------------- */

-- Group average age by gender
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender;

/* -------------------------------------------------------------------------
   2. Attempting to Filter Aggregates with WHERE (Incorrect)
   ------------------------------------------------------------------------- */

-- This query will fail due to SQL processing order:
-- WHERE is evaluated before GROUP BY
-- SELECT gender, AVG(age)
-- FROM employee_demographics
-- WHERE AVG(age) > 40
-- GROUP BY gender;

/* -------------------------------------------------------------------------
   3. Correct Way: Use HAVING to Filter Aggregates
   ------------------------------------------------------------------------- */

-- Use HAVING to filter aggregated data
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

-- Alternative using alias in HAVING clause
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;

/* -------------------------------------------------------------------------
   4. HAVING with LIKE and Aggregation
   ------------------------------------------------------------------------- */

-- Filter occupation with WHERE before grouping
SELECT occupation, AVG(salary) AS avg_salary
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation;

-- Filter occupation and apply aggregate filter using HAVING
SELECT occupation, AVG(salary) AS avg_salary
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;
