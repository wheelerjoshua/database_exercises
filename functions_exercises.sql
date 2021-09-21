USE employees;

-- 2. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE ('E%') AND last_name LIKE ('%e');

-- 3. 
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE ('E%') AND last_name LIKE ('%e');

-- 4. 
SELECT DATEDIFF(CURDATE(), hire_date) AS 'Employment Length'
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25";

-- 5. 
SELECT CONCAT('$', MIN(salary)) AS 'Smallest Salary', CONCAT('$', MAX(salary)) AS 'Largest Salary'
FROM salaries;

-- 6. 
-- SELECT LOWER(CONCAT(SUBSTR(first_name, 1,1), SUBSTR(last_name, 1,4), "_", LPAD(MONTH(birth_date), 2, 0), SUBSTR(YEAR(birth_date), 3, 2))) AS username, first_name, last_name, birth_date
SELECT LOWER(CONCAT(SUBSTR(first_name, 1,1), SUBSTR(last_name, 1,4), "_", SUBSTR(birth_date, 9, 2), SUBSTR(birth_date, 3, 2))) AS username, first_name, last_name, birth_date

FROM employees
LIMIT 10;