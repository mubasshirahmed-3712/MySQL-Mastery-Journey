-- 🔁 TRIGGERS & ⏰ EVENTS IN MYSQL
-- ---------------------------------------------
-- This block demonstrates how to create a Trigger that reacts to INSERT events,
-- and how to create an Event (scheduled job) that deletes rows at intervals.

-- 📌 USE THE CORRECT DATABASE
USE parks_and_recreation;

-- --------------------------------------------------------------------------------
-- 🔁 1. TRIGGER: Automatically insert basic employee info into 'employee_demographics'
--     whenever a new row is inserted into 'employee_salary'
-- --------------------------------------------------------------------------------

-- STEP 1: View current tables (optional)
SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

-- STEP 2: Create Trigger
DELIMITER $$

CREATE TRIGGER employee_insert2
AFTER INSERT ON employee_salary
FOR EACH ROW
BEGIN
    -- Automatically insert into employee_demographics
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

DELIMITER ;

-- STEP 3: Test the Trigger by inserting a row
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

-- STEP 4: Check if the trigger inserted the record into 'employee_demographics'
SELECT * FROM employee_demographics WHERE employee_id = 13;

-- STEP 5: Cleanup inserted test data (optional)
DELETE FROM employee_salary WHERE employee_id = 13;
DELETE FROM employee_demographics WHERE employee_id = 13;

-- --------------------------------------------------------------------------------
-- ⏰ 2. EVENT: Automatically delete employees aged 60 or above every 30 seconds
-- --------------------------------------------------------------------------------

-- STEP 1: Show existing events (optional)
SHOW EVENTS;

-- STEP 2: Drop the event if it already exists
DROP EVENT IF EXISTS delete_retirees;

-- STEP 3: Create the scheduled event
DELIMITER $$

CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    DELETE FROM parks_and_recreation.employee_demographics
    WHERE age >= 60;
END $$

DELIMITER ;

-- STEP 4: Test the Event
-- Insert a test employee aged 60+ (optional)
INSERT INTO employee_demographics (employee_id, first_name, last_name, gender, birth_date, age)
VALUES (14, 'Jerry', 'Gergich', 'Male', '1960-01-01', 65);

-- Wait 30 seconds and run the SELECT to check if Jerry was removed
SELECT * FROM employee_demographics WHERE employee_id = 14;

-- ✅ Done! This block covers:
-- 1. Trigger creation and testing
-- 2. Event creation and scheduled execution
