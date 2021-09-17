-- Tables Exercises
-- Use employees table
USE employees;

-- List all tables in the database
SHOW TABLES;

-- Explore the employees table
DESCRIBE employees;


-- What different data types are present? int, date, varchar, enum

-- Which table(s) do I think contain numeric type column? All of them, due to primary key

-- Which table(s) do I think contain a string type column? departments, dept_emp, dept_manager, employees, salaries, titles

-- Which table(s) do I think contain a date type column? dept_emp_latest_date

-- What is the relationship between the employees and the departments table? The employee number and department number (emp_no and dept_no) are related into the dept_emp table and describe what department each employee is in.
DESCRIBE departments;
DESCRIBE dept_emp;


-- Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;

-- This query yields the following code as a result: 
-- CREATE TABLE `dept_manager` (
--  `emp_no` int NOT NULL,
--  `dept_no` char(4) NOT NULL,
--  `from_date` date NOT NULL,
--  `to_date` date NOT NULL,
--  PRIMARY KEY (`emp_no`,`dept_no`),
--  KEY `dept_no` (`dept_no`),
--  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1