-- 📊 WINDOW FUNCTIONS IN MYSQL
-- Source: Alex The Analyst - Customized for Mubasshir Ahmed
-- Topics: OVER(), PARTITION BY, ROW_NUMBER(), RANK(), DENSE_RANK(), SUM()

USE Parks_and_Recreation;

/* --------------------------------------------------------------------------
   1. Group By vs Window Function - AVG(salary)
   -------------------------------------------------------------------------- */

-- Traditional GROUP BY
SELECT gender, ROUND(AVG(salary), 1) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY gender;

-- Using AVG with OVER() - All rows retained
SELECT dem.employee_id, dem.first_name, gender, salary,
       AVG(salary) OVER() AS avg_salary_all
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

-- AVG with PARTITION BY gender
SELECT dem.employee_id, dem.first_name, gender, salary,
       AVG(salary) OVER(PARTITION BY gender) AS avg_salary_by_gender
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

/* --------------------------------------------------------------------------
   2. SUM with PARTITION and ORDER BY - Rolling total
   -------------------------------------------------------------------------- */

SELECT dem.employee_id, dem.first_name, gender, salary,
       SUM(salary) OVER(PARTITION BY gender ORDER BY employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

/* --------------------------------------------------------------------------
   3. ROW_NUMBER(), RANK(), DENSE_RANK()
   -------------------------------------------------------------------------- */

-- Using ROW_NUMBER by gender & salary
SELECT dem.employee_id, dem.first_name, gender, salary,
       ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

-- Compare with RANK()
SELECT dem.employee_id, dem.first_name, gender, salary,
       ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
       RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_pos
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

-- Compare with DENSE_RANK()
SELECT dem.employee_id, dem.first_name, gender, salary,
       ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
       RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_pos,
       DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_numb
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

/* --------------------------------------------------------------------------
   4. Practice Examples
   -------------------------------------------------------------------------- */

-- Grouped AVG salary by full name
SELECT dem.first_name, dem.last_name, ROUND(AVG(salary), 1) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name;

-- Window AVG salary by gender
SELECT dem.first_name, dem.last_name,
       AVG(salary) OVER(PARTITION BY gender) AS avg_salary_by_gender
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

-- Rolling total salary by gender
SELECT dem.first_name, dem.last_name, gender, salary,
       SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

-- Full comparison: row number, rank, dense rank
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
       ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
       RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_number,
       DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_number
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;
