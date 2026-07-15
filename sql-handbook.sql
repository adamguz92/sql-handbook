-- ==================================================
-- SQL HANDBOOK
-- ==================================================

-- Author: Adam Guz
-- Last update: 2026-07-15

-----------------------------------------------------

-- ==================================================
-- 1. SELECT
-- ==================================================

/* SELECT służy do wybierania kolumn z tabel. */

/* SELECT [nazwa kolumny] służy do wybierania określonych kolumn z tabeli. */

SELECT
    first_name,
    last_name
FROM
    actor;

/* * służy do wybierania wszystkich kolumn z tabeli. */

SELECT
    *
FROM
    actor;

-----------------------------------------------------

-- ==================================================
-- 2. AS
-- ==================================================

/* AS w połączeniu z poleceniem SELECT zmieni nazwę wyświetlanej kolumny. 
Oryginalna nazwa tabeli pozostaje niezmieniona. */

SELECT
    first_name AS name,
    last_name
FROM
    actor
LIMIT 10;

-----------------------------------------------------

-- ==================================================
-- 3. DISTINCT
-- ==================================================

/* DISTINCT usuwa z wyniku duplikaty */

/* Podejrzę tabelę film_category */

SELECT *
FROM film_category;

/* Teraz mogę zobaczyć jakie są kategorie. Żaden z rekordów nie będzie taki sam. */

SELECT DISTINCT category_id
FROM film_category;

-----------------------------------------------------

-- ==================================================
-- 4. CREATE VIEW
-- ==================================================

/* VIEW jest wirtualną tabelą. Nie przechowuje danych, tylko zapytanie SQL, które jest wykonywane przy odwołaniu do widoku. */

CREATE VIEW actor_first_last_name AS
SELECT first_name, last_name
FROM actor;

/* Wyświetlenie wybranej kolumny z VIEW. */

SELECT first_name
FROM actor_first_last_name;

-----------------------------------------------------

-- ==================================================
-- 5. LIMIT
-- ==================================================

/* LIMIT ogranicza liczbę zwracanych wierszy. */

SELECT first_name, last_name
FROM actor
LIMIT 10;

-----------------------------------------------------

