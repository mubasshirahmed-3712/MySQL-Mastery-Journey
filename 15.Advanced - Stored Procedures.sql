-- 📌 Simple Query
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- 📌 Creating a Basic Stored Procedure
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- 📌 Calling the Procedure
CALL large_salaries();

-- ⚠️ This is not best practice. We should use delimiters and BEGIN...END for multiple statements.

-- ❌ This won't work properly without delimiters:
CREATE PROCEDURE large_salaries2()
SELECT *
FROM employee_salary
WHERE salary >= 60000;
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- ✅ Best Practice: Use DELIMITER and BEGIN...END
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;

	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$
DELIMITER ;

-- 📌 Call the procedure
CALL large_salaries2();


-- ✅ Dropping and Recreating Stored Procedure (GUI equivalent)
USE `parks_and_recreation`;
DROP PROCEDURE IF EXISTS `large_salaries3`;

DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;

	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$
DELIMITER ;

-- 📌 Call the recreated SP
CALL large_salaries3();


-- ----------------------------------------------------------------
-- 📌 Stored Procedure with Parameters
USE `parks_and_recreation`;
DROP PROCEDURE IF EXISTS `large_salaries4`;

DELIMITER $$
CREATE PROCEDURE large_salaries4(employee_id_param INT)
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000
	AND employee_id = employee_id_param;
END $$
DELIMITER ;

-- 📌 Call with parameter
CALL large_salaries4(1);

-- ----------------------------------------------------------------
-- ✅ More Examples

-- 🔹 Basic SP again
CREATE PROCEDURE large_sal()
SELECT * 
FROM employee_salary
WHERE salary >= 50000;

CALL large_sal();

-- 🔹 Multi-query SP with delimiter
DELIMITER $$
CREATE PROCEDURE large_salaries5()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 75000;

	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries5();

-- 🔹 SP with custom parameter name (fun!)
DELIMITER $$
CREATE PROCEDURE large_salaries6(huggymuffin INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = huggymuffin;
END $$
DELIMITER ;

CALL large_salaries6(1);
