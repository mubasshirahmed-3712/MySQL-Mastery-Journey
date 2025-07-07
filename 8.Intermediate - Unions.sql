-- 🔗 UNIONs in SQL

-- UNION is used to combine the results of two or more SELECT statements.
-- Each SELECT must return the same number of columns and compatible data types.
-- Unlike JOINs which combine columns side-by-side, UNION combines rows vertically.

-- ⚠️ Mixing different types of data works syntactically, but is not recommended.

-- ❌ Example: Mixing name and job info (not useful, but shows UNION flexibility)
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary
FROM employee_salary;


-- ✅ Example: Combining two lists of people by name (removes duplicates by default)
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;


-- 🟰 UNION is the same as UNION DISTINCT
SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;


-- 🔁 UNION ALL includes duplicates
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;



-- 🎯 USE CASE: Creating a list of employees for potential budget cuts
-- Criteria: Over 40 years old, or earning >= 70,000
-- Each group is tagged with a label using a constant string

-- Step 1: Female employees over 40
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'

UNION

-- Step 2: Male employees over 40
SELECT first_name, last_name, 'Old Man'
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'

UNION

-- Step 3: Highly paid employees (salary >= 70,000)
SELECT first_name, last_name, 'Highly Paid Employee'
FROM employee_salary
WHERE salary >= 70000

-- Final sorting for cleaner output
ORDER BY first_name, last_name;
