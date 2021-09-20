USE `employees`;

-- 2. Irena Reutanauer, Vidya Simmen
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- 3. Irena Acton, Vidya Zweizig
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- 4. Irena Acton, Maya Zyda
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- 5. 899, 10021 Ramzi Erde, 499648 Tadahiro Erde
SELECT *
FROM employees
WHERE last_name LIKE "%e" AND last_name LIKE "E%"
ORDER BY emp_no;

-- 6. 899, Teiji Eldridge, Sergi Erde
SELECT *
FROM employees
WHERE last_name LIKE "%e" AND last_name LIKE "E%"
ORDER BY hire_date DESC;

-- 7. 362, Khun Bernini, Douadi Pettis
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25"
ORDER BY birth_date ASC, hire_date DESC;