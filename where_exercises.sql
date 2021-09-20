-- 2. 709
SELECT *
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 3. It matches Q2, 709
SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

-- 4. 441.
SELECT *
FROM employees
WHERE gender = 'M' AND (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya');

-- 5. 7330
SELECT *
FROM employees
WHERE last_name LIKE ("E%");

-- 6. 30723
SELECT *
FROM employees
WHERE last_name LIKE ("E%") OR last_name LIKE ("%e");

-- 7. 899
SELECT *
FROM employees
WHERE last_name LIKE ("E%") AND last_name LIKE ("%e");
-- 24292
SELECT *
FROM employees
WHERE last_name LIKE ("%e");


-- 8. 135214
SELECT *
FROM employees
WHERE hire_date LIKE "199%";


-- 9. 842
SELECT *
FROM employees
WHERE birth_date LIKE "%12-25";


-- 10. 362
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25";


-- 11. 1873
SELECT *
FROM employees
WHERE last_name LIKE "%q%";


-- 12. 547
SELECT *
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%";