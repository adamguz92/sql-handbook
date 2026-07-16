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
-- 2. AS (alias)
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

-- ==================================================
-- 6. COUNT()
-- ==================================================

/* COUNT() zwraca ilość niepustych wartości w wyrażeniu podanym jako argument funkcji. */

SELECT COUNT(first_name)
FROM actor; /* Wynik: 200 */

/* UWAGA!
Jeżeli chcę zliczyć unikalne wartości,
to funkcja DISTINCT musi znajdować się w COUNT(). */

-- ==================================================
-- 6.1. COUNT(DISTINCT)
-- ==================================================

SELECT COUNT(DISTINCT first_name)
FROM actor; /* 121 rekordów */

/* Aby uczynić rezultat bardziej czytelnym mogę napisać kod w taki sposób: */

SELECT COUNT(last_name) AS count_actors
FROM actor; /* Przy tym zapisie otrzymam nagłówek. */

/* 
Good practice

COUNT(*) jest zwykle używane do zliczania wszystkich wierszy.

COUNT(column_name) stosuj wtedy,
gdy interesują Cię tylko niepuste wartości.
*/

-- ==================================================
-- 6.2. COUNT()  multiple columns
-- ==================================================

/* Zliczanie wszystkich rekordów wielu zmiennych z tabeli za pomoca COUNT() */

SELECT 
    COUNT(first_name) AS count_names,
    COUNT(last_name) AS count_fornames
FROM actor;

/* Zliczanie rekordów bez duplikatów wielu zmiennych za pomocą COUNT(DISTINCT) */
SELECT 
    COUNT(DISTINCT first_name) AS count_names,
    COUNT(DISTINCT last_name) AS count_fornames
FROM actor;

-----------------------------------------------------

-- ==================================================
-- 7. Kolejność wykonywania poleceń
-- ==================================================

/*
1. FROM 
2. SELECT 
3. LIMIT
 
*/
-----------------------------------------------------

-- ==================================================
-- 8. Podręcznik stylu SQL
-- ==================================================

/* https://www.sqlstyle.guide/pl/ */

-----------------------------------------------------