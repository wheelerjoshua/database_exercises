USE employees;

-- 1. 
SELECT first_name, last_name, hire_date
FROM employees
JOIN dept_emp USING(emp_no)
WHERE hire_date IN 
	(
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
	)
AND to_date > CURDATE();
-- 55

-- 2.
SELECT DISTINCT title
FROM titles
WHERE emp_no IN 
	(
	SELECT emp_no
	FROM employees
	JOIN dept_emp USING(emp_no)
	WHERE first_name LIKE 'Aamod' and to_date > now()
	);

-- 3. 
SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN
	(
	SELECT emp_no
	FROM dept_emp 
	WHERE to_date > CURDATE()
	);
-- 59900

-- Why won't this work? There are multiple per emp_no in the past, so we cannot use to_date < now()
/*
SELECT *
FROM employees
join dept_emp using(emp_no)
WHERE emp_no IN 
	(
	SELECT emp_no
	FROM dept_emp
	WHERE to_date < CURDATE()
	);
-- 85108
*/


-- 4. 
SELECT CONCAT(first_name, ' ', last_name) as 'Female Managers'
FROM employees
WHERE emp_no IN
	(
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > CURDATE()
	)
AND gender = 'F';
-- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- 5.
SELECT CONCAT(first_name, ' ', last_name) as Employee, salary
FROM employees
JOIN salaries USING(emp_no)
WHERE salary > 
	(
	SELECT AVG(salary)
	FROM salaries
	)
AND to_date > CURDATE();
-- 154543

-- 6. 
SELECT COUNT(salary)
FROM salaries
WHERE to_date > now()
AND salary > (
	(select max(salary) from salaries where to_date > now())
				- (select std(salary) from salaries where to_date > now())
	);


SELECT (SELECT COUNT(salary)
		FROM salaries
		WHERE to_date > now()
		AND salary > (
			(select max(salary) from salaries where to_date > now())
			- (select std(salary) from salaries where to_date > now())
			)) 
			/ 
			(SELECT COUNT(*)
			FROM salaries
			WHERE to_date > now()) 
			* 100;


/* Original answer 
SELECT COUNT(*) as salaries_within_one, concat(cast(78/240124*100 as char),'%') as percentage_of_all
FROM salaries
WHERE to_date > CURDATE()
AND (salary - (SELECT MAX(salary) FROM salaries))
	/
	(SELECT stddev(salary) FROM salaries) BETWEEN -1 AND 1;
-- 78, 0.0325%
*/


-- BONUS
-- 1.
SELECT dept_name as 'Departments with Female Mangers'
FROM departments
WHERE dept_no IN
	(
	SELECT dept_no
	FROM dept_manager
	JOIN employees USING(emp_no)
	WHERE gender LIKE 'F'
	);
-- Customer Service, Development, Finance, Human Resources, Production, Quality Management, Research
	
-- 2. 
SELECT first_name, last_name, salary
FROM employees
JOIN salaries USING(emp_no)
WHERE salary IN
	(
	SELECT MAX(salary)
	FROM salaries
	);
-- Tokuyasu Pesch, 158220
	
	
-- 3.
SELECT dept_name
FROM departments
WHERE dept_no IN 
	(
	SELECT dept_no
	FROM employees
	JOIN salaries USING(emp_no)
	JOIN dept_emp USING(emp_no)
	WHERE salary IN
		(
		SELECT MAX(salary)
		FROM salaries
		)
	);
-- Sales