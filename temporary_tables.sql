USE hopper_1544;

-- 1.
CREATE TEMPORARY TABLE hopper_1544.employees_with_departments AS
(
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100
);

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

/*
CREATE TEMPORARY TABLE hopper_1544.employees_with_departments AS
(
SELECT emp_no, dept_no, dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100
);
*/

-- 2.
CREATE TEMPORARY TABLE hopper_1544.payment AS
(
SELECT *
FROM sakila.payment
);

/* Change column without adding or removing */
ALTER TABLE payment MODIFY amount FLOAT;
UPDATE payment SET amount = amount * 100;

/* Use separate column to achieve answer */
ALTER TABLE payment ADD amount_in_cents INT;
UPDATE payment SET amount_in_cents = amount * 100;
ALTER TABLE payment DROP amount;
ALTER TABLE payment RENAME COLUMN amount_in_cents TO amount;

SELECT * from payment;

-- To reset table
DROP TABLE payment;

-- 3.
USE hopper_1544;
/* What do I need in this table?
Department Name | Average Salary | ZSCore compared to historical average
*/
CREATE TEMPORARY TABLE hopper_1544.dept_average_salary
SELECT dept_no, dept_name, AVG(salary) as average_salary
from employees.salaries
JOIN employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where salaries.to_date > now()
group by dept_name;

ALTER TABLE dept_average_salary ADD zscore float;

SELECT * from dept_average_salary;

-- OVERALL HISTORIC AVERAGE
UPDATE dept_average_salary 
SET zscore = 
			(average_salary - (SELECT AVG(salary) FROM employees.salaries)) 
			/ 
			(SELECT stddev(salary) FROM employees.salaries);
			

-- HISTORIC AVERAGE
UPDATE dept_average_salary 
SET zscore = 
			(average_salary - (SELECT AVG(salary) FROM employees.salaries where to_date <= now())) 
			/ 
			(SELECT stddev(salary) FROM employees.salaries);
			

SELECT * from dept_average_salary order by zscore DESC;

-- Best: Sales
-- Worst: Human Resources