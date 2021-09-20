USE `employees`;

-- 2. Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- 3. Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5;

-- 4. LIMIT is how many results per page, OFFSET changes the limited results displayed by skipping hte designated amount, page number is the OFFSET divided by the LIMIT. 
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5 OFFSET 50;