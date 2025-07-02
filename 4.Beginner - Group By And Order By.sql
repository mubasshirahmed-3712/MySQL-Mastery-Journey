-- Beginner Lesson: GROUP BY and ORDER BY Clauses
-- Source: Alex The Analyst YouTube MySQL Series
-- Customized by Mubasshir Ahmed (Date: 22 June 2025)
-- Description: Demonstrates use of GROUP BY for aggregation and ORDER BY for sorting results.
-- Prerequisite: Database `Parks_and_Recreation` with tables:
--               employee_demographics, employee_salary

/* -------------------------------------------------------------------------
   0. Set the working database
   ------------------------------------------------------------------------- */
USE Parks_and_Recreation;

/* -------------------------------------------------------------------------
   1. GROUP BY Clause Basics
   ------------------------------------------------------------------------- */

-- View full table for reference
SELECT *
FROM employee_demographics;

-- Group by gender
SELECT gender
FROM employee_demographics
GROUP BY gender;

-- Invalid: grouping by gender but selecting first_name (non-aggregated)
-- Will throw error in strict SQL modes
SELECT first_name
FROM employee_demographics
GROUP BY gender;

-- Group by occupation
SELECT occupation
FROM employee_salary
GROUP BY occupation;

-- Group by multiple columns: occupation and salary
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

-- Aggregation: Average age per gender
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender;

-- Multiple aggregations: MIN, MAX, COUNT, AVG of age by gender
SELECT gender,
       MIN(age)  AS min_age,
       MAX(age)  AS max_age,
       COUNT(*)  AS count_people,
       AVG(age)  AS avg_age
FROM employee_demographics
GROUP BY gender;

/* -------------------------------------------------------------------------
   2. ORDER BY Clause
   ------------------------------------------------------------------------- */

-- Default ascending order by first_name
SELECT *
FROM employee_demographics
ORDER BY first_name;

-- Descending order by first_name
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

-- Multiple columns ordering: by gender and then age
SELECT *
FROM employee_demographics
ORDER BY gender, age;

-- Descending order by gender and age
SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC;

-- Using column positions: gender (5th), age (4th)
-- Not recommended for production use
SELECT *
FROM employee_demographics
ORDER BY 5 DESC, 4 DESC;

-- Best practice: use explicit column names
SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC;
