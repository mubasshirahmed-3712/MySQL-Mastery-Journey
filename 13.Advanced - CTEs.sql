-- 📌 Common Table Expressions (CTEs)

-- Basic aggregate query without CTE
SELECT gender, 
       AVG(salary),
       MAX(salary),
       MIN(salary),
       COUNT(salary)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
GROUP BY gender;

-- ✅ Using CTE to store that result and reference later
WITH CTE_Example (gen, avg, max, min, count) AS (
    SELECT gender, 
           AVG(salary) AS avgsal,
           MAX(salary) AS maxsal,
           MIN(salary) AS minsal,
           COUNT(salary) AS countsal
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT *
FROM CTE_Example;

-- ✅ Subquery version for same logic
SELECT AVG(avgsal)
FROM (
    SELECT gender, 
           AVG(salary) AS avgsal,
           MAX(salary),
           MIN(salary),
           COUNT(salary)
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
) AS example_subquery;

-- ✅ Same logic using CTE
WITH CTE_Example AS (
    SELECT gender, 
           AVG(salary) AS avgsal,
           MAX(salary) AS maxsal,
           MIN(salary) AS minsal,
           COUNT(salary) AS countsal
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT AVG(avgsal)
FROM CTE_Example;

-- ✅ Multiple CTEs in one query
WITH CTE_Example AS (
    SELECT employee_id, gender, birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS (
    SELECT employee_id, salary
    FROM employee_salary
    WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
    ON CTE_Example.employee_id = CTE_Example2.employee_id;

-- ✅ Cleaner column naming inside CTE to avoid backticks
WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS (
    SELECT gender, 
           SUM(salary),
           MIN(salary),
           MAX(salary),
           COUNT(salary)
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT gender, 
       ROUND(AVG(sum_salary / count_salary), 2) AS avg_salary
FROM CTE_Example
GROUP BY gender;

-- ✅ Multi-CTE example with LEFT JOIN
WITH CTE_Example AS (
    SELECT employee_id, gender, birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS (
    SELECT employee_id, salary
    FROM parks_and_recreation.employee_salary
    WHERE salary >= 50000
)
SELECT *
FROM CTE_Example cte1
LEFT JOIN CTE_Example2 cte2
    ON cte1.employee_id = cte2.employee_id;
