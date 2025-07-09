-- Intermediate Lesson: SUBQUERIES (Queries within Queries)
-- Source: Alex The Analyst YouTube MySQL Series
-- Customized by Mubasshir Ahmed (Date: 22 June 2025)
-- Description: Demonstrates subqueries in WHERE, SELECT, and FROM clauses.
-- Prerequisite: Database `Parks_and_Recreation` with tables:
--               employee_demographics, employee_salary

/* -------------------------------------------------------------------------
   0. Set the working database
   ------------------------------------------------------------------------- */
USE Parks_and_Recreation;

/* -------------------------------------------------------------------------
   1. Subquery in WHERE Clause (IN)
   ------------------------------------------------------------------------- */

-- Employees who work in the Parks & Recreation department (dept_id = 1)
SELECT *
FROM employee_demographics
WHERE employee_id IN (
    SELECT employee_id
    FROM employee_salary
    WHERE dept_id = 1
);

/* -------------------------------------------------------------------------
   2. Subquery in SELECT Clause (Scalar Subquery)
   ------------------------------------------------------------------------- */

-- Compare each salary to the overall average salary
SELECT first_name,
       salary,
       (SELECT AVG(salary) FROM employee_salary) AS overall_avg_salary
FROM employee_salary;

/* -------------------------------------------------------------------------
   3. Subquery in FROM Clause (Derived Table)
   ------------------------------------------------------------------------- */

-- Build a mini‑table with per‑gender stats, then query it
SELECT gender,
       Avg_age,
       Max_age,
       Min_age,
       Count_age
FROM (
    SELECT gender,
           AVG(age)  AS Avg_age,
           MAX(age)  AS Max_age,
           MIN(age)  AS Min_age,
           COUNT(*)  AS Count_age
    FROM employee_demographics
    GROUP BY gender
) AS gender_stats;

/* -------------------------------------------------------------------------
   4. Nested Subquery Example (Average of Counts per Gender)
   ------------------------------------------------------------------------- */

-- Average of the gender counts (how many people per gender on average)
SELECT AVG(Count_age) AS avg_count_per_gender
FROM (
    SELECT gender,
           COUNT(*) AS Count_age
    FROM employee_demographics
    GROUP BY gender
) AS gender_counts;
