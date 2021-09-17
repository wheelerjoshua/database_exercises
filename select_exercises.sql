USE albums_db;

-- 3a. 31 rows
-- 3b. 23
SELECT DISTINCT artist
FROM `albums`;

-- 3c. id
SHOW CREATE TABLE albums;

-- 3d. 1967, 2011
SELECT DISTINCT release_date
FROM albums
ORDER BY release_date ASC;

-- 4
-- 4a.
SELECT artist, name AS 'Album' 
FROM albums
WHERE artist = 'Pink Floyd';

-- 4b.
SELECT artist, name AS 'Album', release_date AS 'Release Date'
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- 4c.
SELECT artist, name AS 'Album', genre AS 'Genre'
FROM albums
WHERE name = 'Nevermind';

-- 4d.
SELECT name AS 'Album', release_date AS 'Release Date'
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

-- 4e.
SELECT name AS 'Album', sales AS 'Certified Sales'
FROM albums
WHERE sales < 20;

-- 4f. They are various specific genres with different names and since computers are literal, a query for the 'Rock' genre would not yield results that are not specifically labeled 'Rock'.
SELECT name AS 'Album', genre AS 'Genre'
FROM albums
WHERE genre = 'Rock';