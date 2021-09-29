USE employees;

-- 1.
SELECT emp_no, dept_no, from_date, to_date,
	CASE
	WHEN dept_emp.to_date > now() THEN 1
	ELSE 0
	END AS is_current_employee
FROM dept_emp;

-- 2.
SELECT CONCAT(first_name, ' ', last_name) as employee_name, 
	CASE
	WHEN last_name > 'A' and last_name < 'I' THEN 'A-H'
	WHEN last_name > 'I' and last_name < 'R' THEN 'I-Q'
	WHEN last_name > 'R' and last_name <= 'Z' THEN 'R-Z'
	ELSE 'R-Z'
	END AS alpha_group
from employees;

-- Alternate solution with less code
SELECT CONCAT(first_name, ' ', last_name) as employee_name, 
	CASE
	WHEN last_name < 'I' THEN 'A-H'
	WHEN last_name < 'R' THEN 'I-Q'
	ELSE 'R-Z'
	END AS alpha_group
from employees;

-- 3.
SELECT
	COUNT(CASE WHEN birth_date like '195%' THEN birth_date ELSE NULL END) as '1950s',
	COUNT(CASE WHEN birth_date like '196%' THEN birth_date ELSE NULL END) as '1960s'
FROM employees;


-- BONUS
-- Average salary for each department
SELECT dept_name, AVG(salary)
FROM salaries
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date > now()
GROUP BY dept_name;
-- Group into dept_groups
SELECT dept_name,
	CASE
	WHEN dept_name IN ('research','development') THEN 'R&D'
	WHEN dept_name IN ('sales','marketing') THEN 'Sales & Marketing'
	WHEN dept_name IN ('production','quality management') THEN 'Prod & QM'
	WHEN dept_name IN ('finance','human resources') THEN 'Finance & HR'
	ELSE dept_name
	END AS dept_group
FROM departments;

-- Salary for each dept_group
CREATE TEMPORARY TABLE hopper_1544.dept_group_average_salary AS(
SELECT dept_name, average_salary,
	CASE
	WHEN dept_name IN ('research','development') THEN 'R&D'
	WHEN dept_name IN ('sales','marketing') THEN 'Sales & Marketing'
	WHEN dept_name IN ('production','quality management') THEN 'Prod & QM'
	WHEN dept_name IN ('finance','human resources') THEN 'Finance & HR'
	ELSE dept_name
	END AS dept_group
FROM departments
-- JOIN dept_emp USING(dept_no) 
-- JOIN salaries USING(emp_no) s
JOIN 
	(
	SELECT dept_name, AVG(salary) as average_salary
	FROM salaries
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
	WHERE salaries.to_date > now()
	GROUP BY dept_name
	) as avgs
USING(dept_name)
);

select * from hopper_1544.dept_group_average_salary;

SELECT dept_group, ROUND(AVG(average_salary), 2) AS avg_salary
FROM hopper_1544.dept_group_average_salary
GROUP BY dept_group;