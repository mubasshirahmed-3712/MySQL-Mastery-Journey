-- Using Temporary Tables
-- Temporary tables are tables that are only visible to the session that created them. 
-- They can be used to store intermediate results for complex queries or to manipulate data before inserting it into a permanent table.

-- There's 2 ways to create temp tables:
-- 1. This is the less commonly used way - which is to build it exactly like a real table and insert data into it

CREATE TEMPORARY TABLE temp_table
(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);

-- If we execute this, it gets created and we can actually query it.
SELECT *
FROM temp_table;

-- Notice that if we refresh our tables, it isn't there. 
-- It isn't an actual table. It's just a table in memory.

-- Now obviously it's blank so we would need to insert data into it like this:
INSERT INTO temp_table
VALUES ('Alex','Freberg','Lord of the Rings: The Twin Towers');

-- Now when we run and execute it again, we have our data:
SELECT *
FROM temp_table;

-- The second way is much faster and my preferred method
-- 2. Build it by inserting data into it - easier and faster

CREATE TEMPORARY TABLE salary_over_50k AS
SELECT *
FROM employee_salary
WHERE salary > 50000;

-- If we run this query we get our output
SELECT *
FROM salary_over_50k;

-- This is the primary way I've used temp tables, especially if I'm just querying data
-- and have some complex data I want to put into boxes or these temp tables to use later.
-- It helps me categorize and separate it out.

-- In the next lesson we will look at the Temp Tables vs CTEs
