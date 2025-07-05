-- Intermediate Lesson: SQL JOINS (Inner, Outer, Self, Multi-table)
-- Source: Alex The Analyst YouTube MySQL Series
-- Customized by Mubasshir Ahmed (Date: 22 June 2025)
-- Description: Demonstrates INNER JOIN, LEFT/RIGHT OUTER JOIN, SELF JOIN, and joining multiple tables.
-- Prerequisite: Database `Parks_and_Recreation` with tables:
--               employee_demographics, employee_salary, parks_departments

/* -------------------------------------------------------------------------
   0. Set the working database
   ------------------------------------------------------------------------- */
USE Parks_and_Recreation;

/* -------------------------------------------------------------------------
   1. Explore Tables
   ------------------------------------------------------------------------- */

SELECT * FROM employee_demographics;
SELECT * FROM employee_salary;

/* -------------------------------------------------------------------------
   2. INNER JOIN (Only matching records from both tables)
   ------------------------------------------------------------------------- */

SELECT *
FROM employee_demographics
JOIN employee_salary
    ON employee_demographics.employee_id = employee_salary.employee_id;

-- Using aliases
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

/* -------------------------------------------------------------------------
   3. LEFT and RIGHT OUTER JOINS
   ------------------------------------------------------------------------- */

-- LEFT JOIN: All records from salary, matched records from demographics
SELECT *
FROM employee_salary sal
LEFT JOIN employee_demographics dem
    ON dem.employee_id = sal.employee_id;

-- RIGHT JOIN: All records from demographics, matched records from salary
SELECT *
FROM employee_salary sal
RIGHT JOIN employee_demographics dem
    ON dem.employee_id = sal.employee_id;

/* -------------------------------------------------------------------------
   4. SELF JOIN (Join a table to itself)
   ------------------------------------------------------------------------- */

-- Example: Secret Santa based on employee_id + 1
SELECT emp1.employee_id AS emp_santa,
       emp1.first_name AS santa_first_name,
       emp1.last_name  AS santa_last_name,
       emp2.employee_id,
       emp2.first_name,
       emp2.last_name
FROM employee_salary emp1
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id;

/* -------------------------------------------------------------------------
   5. JOINING Multiple Tables
   ------------------------------------------------------------------------- */

-- Preview department table
SELECT * FROM parks_departments;

-- INNER JOIN across all three tables
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
JOIN parks_departments dept
    ON dept.department_id = sal.dept_id;

-- LEFT JOIN to include employees without a department (e.g., Andy)
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
    ON dept.department_id = sal.dept_id;
