-- 📌 SQL STRING FUNCTIONS — Clean & Manipulate Text

-- 🔢 LENGTH — Returns number of characters
SELECT LENGTH('sky');

SELECT first_name, LENGTH(first_name) AS name_length
FROM employee_demographics;

-- 🔠 UPPER — Converts text to uppercase
SELECT UPPER('sky');
SELECT first_name, UPPER(first_name) AS upper_name
FROM employee_demographics;

-- 🔡 LOWER — Converts text to lowercase
SELECT LOWER('SKY');
SELECT first_name, LOWER(first_name) AS lower_name
FROM employee_demographics;

-- ✂️ TRIM — Removes leading and trailing spaces
SELECT TRIM('   sky   ') AS trimmed_value;

-- ✂️ LTRIM — Removes leading (left) spaces
SELECT LTRIM('     I love SQL') AS left_trimmed;

-- ✂️ RTRIM — Removes trailing (right) spaces
SELECT RTRIM('I love SQL    ') AS right_trimmed;

-- 🔚 LEFT — Extract characters from the beginning
SELECT LEFT('Alexander', 4) AS left_part;
SELECT first_name, LEFT(first_name, 4) AS first_4_letters
FROM employee_demographics;

-- 🔙 RIGHT — Extract characters from the end
SELECT RIGHT('Alexander', 6) AS right_part;
SELECT first_name, RIGHT(first_name, 4) AS last_4_letters
FROM employee_demographics;

-- 🧵 SUBSTRING — Extract characters from a position
SELECT SUBSTRING('Alexander', 2, 3) AS substring_example;

-- 🎂 Example: Extract birth year from birth_date
SELECT birth_date, SUBSTRING(birth_date, 1, 4) AS birth_year
FROM employee_demographics;

-- 🔄 REPLACE — Replace characters in string
SELECT REPLACE(first_name, 'a', 'z') AS replaced_name
FROM employee_demographics;

-- 🔎 LOCATE — Find position of substring
SELECT LOCATE('x', 'Alexander') AS position_of_x;
SELECT LOCATE('e', 'Alexander') AS position_of_first_e;

-- Apply LOCATE to table column
SELECT first_name, LOCATE('a', first_name) AS position_of_a
FROM employee_demographics;

SELECT first_name, LOCATE('Mic', first_name) AS position_of_mic
FROM employee_demographics;

-- 🔗 CONCAT — Combine strings together
SELECT CONCAT('Alex', 'Freberg') AS combined_text;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;
