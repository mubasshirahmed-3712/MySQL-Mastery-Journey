-- Beginner Lesson: WHERE Clause and LIKE Operator
-- Source: Alex The Analyst YouTube MySQL Series
-- Customized by Mubasshir Ahmed (Date: 22 June 2025)
-- Description: Demonstrates filtering using WHERE clause, logical operators,
--              comparison operators, and pattern matching with LIKE.
-- Prerequisite: Database `Parks_and_Recreation` with tables:
--               employee_demographics, employee_salary

/* -------------------------------------------------------------------------
   0. Set the working database
   ------------------------------------------------------------------------- */
USE Parks_and_Recreation;

/* -------------------------------------------------------------------------
   1. Basic WHERE Clause
   ------------------------------------------------------------------------- */

-- Filter by exact first name
SELECT *
FROM employee_salary
WHERE first_name = 'Leslie';

-- Filter where salary is greater than or equal to 50000
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- Filter where gender is not Female
SELECT *
FROM employee_demographics
WHERE gender != 'Female';

-- Filter where birth_date is after Jan 1, 1985
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- Combine conditions with OR and NOT
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
   OR NOT gender = 'Female';

-- Combine multiple conditions using AND and OR
SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44)
   OR age > 55;

/* -------------------------------------------------------------------------
   2. Pattern Matching with LIKE
   ------------------------------------------------------------------------- */

-- Names starting with 'jer'
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'jer%';

-- Names containing 'er'
SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%';

-- Names that are 4 characters long and start with 'a'
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___';

-- Birth dates that start with '1989'
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%';
