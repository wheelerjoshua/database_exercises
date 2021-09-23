USE join_example_db;

/* Join Example Database */
-- 1. 24
SELECT *
FROM users
JOIN roles;

-- 2. 
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;
-- There are 4 rows

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;
-- There are 6 results from usernames that do not have role_id assigned

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;
-- There are 5 rows from role that did not have a user assigned to the role_id

-- 3.
SELECT roles.name AS role, COUNT(*)
FROM users
JOIN roles ON users.role_id = roles.id
GROUP BY role;
-- Admin 1, Author 1, Reviewer 2

/* Employees Database */
-- 1. 
USE employees

-- 2.
SELECT dept_name AS 'Department Name', 
       CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM departments
JOIN dept_manager USING(dept_no)
JOIN employees USING(emp_no)
WHERE to_date > now()
ORDER BY dept_name;
/* Issue where aliases need to be strings to run the code because of the spaces between words */

-- 3. 
SELECT dept_name AS 'Department Name',
       CONCAT(first_name, ' ', last_name) AS 'Manager Name'
FROM departments
JOIN dept_manager USING(dept_no)
JOIN employees USING(emp_no)
WHERE gender LIKE 'F' AND to_date > now()
ORDER BY dept_name;

-- 4.
SELECT title AS Title, COUNT(*) AS Count
FROM titles
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE titles.to_date > now() AND dept_emp.to_date > now() AND dept_name = 'Customer Service'
GROUP BY title
ORDER BY title;

-- 5. 
SELECT dept_name AS 'Department Name', 
       CONCAT(first_name, ' ', last_name) AS 'Department Manager',
          salary AS Salary
FROM departments
JOIN dept_manager USING(dept_no)
JOIN employees USING(emp_no)
JOIN salaries USING(emp_no)
WHERE dept_manager.to_date > now() AND salaries.to_date > now()
ORDER BY dept_name;

-- 6.
SELECT dept_no, dept_name, COUNT(*) AS num_employees
FROM dept_emp
JOIN departments USING(dept_no)
WHERE to_date > now()
GROUP BY dept_no
ORDER BY dept_no;

-- 7. 
SELECT dept_name, AVG(salary) AS average_salary
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > now() AND dept_emp.to_date > now()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;
-- Sales	88842.1590

-- 8. 
SELECT first_name, last_name, salary
FROM employees
JOIN salaries USING(emp_no)
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE dept_name LIKE 'Marketing' AND salaries.to_date > now()
ORDER BY salary DESC
LIMIT 1;
-- Akemi Warwick	145128

-- 9. 
SELECT first_name, last_name, salary, dept_name
FROM departments
JOIN dept_manager USING(dept_no)
JOIN employees USING(emp_no)
JOIN salaries USING(emp_no)
WHERE dept_manager.to_date > now() AND salaries.to_date > now()
ORDER BY salary DESC
LIMIT 1;

-- 10. 
/* Instructor assisted solution*/
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', 
       dept_name,
          CONCAT(managers.first_name, ' ', managers.last_name) AS 'Manager Name'
FROM employees e
JOIN dept_emp d_e USING(emp_no)
JOIN departments d USING(dept_no)
JOIN dept_manager d_m USING(dept_no)
JOIN employees as managers ON managers.emp_no = d_m.emp_no
/* Self join and aliases allow us to differentiate the employees names from the managers names.
in our selection. */
WHERE d_e.to_date > now() AND d_m.to_date > now();


/* ORIGINAL CODE
SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS 'Employee Name', dept_name,
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
JOIN dept_manager USING(dept_no)
WHERE dept_emp.to_date > now();
*/ 

-- 11.
/* Source used to assist in solution was a comment by henry606 on this page
https://leetcode.com/problems/department-highest-salary/solution/ */

SELECT CONCAT(first_name, ' ', last_name) as employee_name, d.dept_name, s.salary
FROM employees AS e
JOIN salaries s USING(emp_no)
JOIN dept_emp d_e USING(emp_no)
JOIN departments d USING(dept_no)

JOIN (SELECT MAX(salary) as salary, dept_name FROM salaries
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
	GROUP BY dept_name) AS max 
ON s.salary = max.salary AND d.dept_name = max.dept_name
WHERE s.to_date > now();

-- Original attempts
/*SELECT first_name, dept_name, MAX(salary)
-- first_name, dept_name, MAX(salary)
FROM salaries
JOIN employees USING(emp_no)
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salary IN (SELECT MAX(salary)
				FROM salaries
			  GROUP BY dept_n)
	 AND salaries.to_date > now();
WHERE salaries.to_date > now()
GROUP BY dept_no, emp_no; */
/* SELECT CONCAT(first_name, ' ', last_name) employee_name,
	   dept_name, 
	   salary
FROM salaries 		
JOIN employees USING(emp_no)
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date > now(); */
/* SELECT dept_name, max.salary from (SELECT dept_name, MAX(salary) as salary
FROM salaries
JOIN dept_emp using(emp_no)
JOIN departments as d using(dept_no)
GROUP BY dept_name
) AS max
join (SELECT CONCAT(first_name, ' ', last_name) as employee_name, dept_name FROM employees
JOIN dept_emp using(emp_no)
JOIN departments using(dept_no)) as e ON e.dept_name = max.dept_name
;								
*/


-- Extra bonus.
SELECT dept_name, ROUND(AVG(salary)) as average_salary
FROM salaries s
JOIN dept_emp de using(emp_no)
JOIN departments d using(dept_no)
GROUP BY dept_name
ORDER BY average_salary DESC;