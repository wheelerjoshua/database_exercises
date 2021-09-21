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

-- 4. LIMIT is how many results per page, OFFSET changes the limited results displayed by skipping the designated amount, page n = limit 5 offset (n-1) * 5. 
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5 OFFSET 45;

/* 231580	1957-12-25	Christophe	Baca	F	1990-08-11
275621	1961-12-25	Moie	Birsak	M	1990-08-11
494492	1957-12-25	Chikako	Ibel	F	1990-08-12
48396	1955-12-25	Shounak	Jansen	M	1990-08-13
17351	1961-12-25	Zhigen	Boissier	M	1990-08-18 */