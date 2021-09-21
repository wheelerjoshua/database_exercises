USE employees;

-- 2. 
SELECT DISTINCT title
FROM titles;
-- 7 unique titles

-- 3. 
SELECT last_name
FROM employees 
WHERE last_name LIKE "E%e"
GROUP BY last_name;

-- 4. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE first_name LIKE 'E%e' AND last_name LIKE 'E%e'
GROUP BY full_name;

-- 5. 
SELECT last_name
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
GROUP BY last_name;
-- Chleq Lindqvist Qiwen

-- 6. 
SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
GROUP BY last_name;
-- Chleq 189, Lindqvist 190, Qiwen 168

-- 7. 
SELECT first_name, COUNT(*) AS Count, gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name;

-- 8. 
SELECT LOWER(CONCAT(
	SUBSTR(first_name, 1,1),
	SUBSTR(last_name, 1,4), 
	"_",
	SUBSTR(birth_date, 9, 2),
	SUBSTR(birth_date, 3, 2)
)) AS username, COUNT(*) AS how_many
FROM employees
GROUP BY username
ORDER BY how_many DESC;

-- 8. BONUS = 5581
SELECT LOWER(CONCAT(
	SUBSTR(first_name, 1,1),
	SUBSTR(last_name, 1,4), 
	"_",
	SUBSTR(birth_date, 9, 2),
	SUBSTR(birth_date, 3, 2)
)) AS username, COUNT(*) AS amount
FROM employees
GROUP BY username
HAVING amount > 1
ORDER BY amount DESC;

-- 9a. 
SELECT AVG(salary)
FROM salaries
WHERE from_date < NOW();

SELECT AVG(salary)
FROM salaries
WHERE to_date > NOW();

-- 9b. 
SELECT emp_no, AVG(salary)
FROM salaries
WHERE from_date < NOW()
GROUP BY emp_no;

-- 9c.
SELECT emp_no, AVG(salary)
FROM salaries
WHERE to_date > NOW()
GROUP BY emp_no;

-- 9d. 
SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no;

-- 9e.
SELECT emp_no, MAX(salary) AS max
FROM salaries
GROUP BY emp_no
HAVING max > 150000;

-- 9f. 
SELECT emp_no, AVG(salary) AS average
FROM salaries
GROUP BY emp_no
HAVING average BETWEEN 80000 AND 90000;