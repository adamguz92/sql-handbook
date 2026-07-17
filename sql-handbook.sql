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
2. WHERE
3. SELECT 
3. LIMIT
 
*/
-----------------------------------------------------

-- ==================================================
-- 8. Podręcznik stylu SQL
-- ==================================================

/* https://www.sqlstyle.guide/pl/ */

-----------------------------------------------------

-- ==================================================
-- 9. WHERE - filtrowanie z liczbami
-- ==================================================

/* WHERE zawęża wyniki do wskazanych cech zmiennych. */

/* Podejrzę tabelę film. */

SELECT *
FROM film;

/* Tabela film ma kolumnę release_year. 
Wyświetlę filmy dłuższe niż 100 minut. */

SELECT COUNT(*) 
FROM film; /* Wynik: 1000 */

SELECT title
FROM film
WHERE length > 90;

/* Ile jest filmów dłuższych niż 90 minut? */

SELECT COUNT(*) AS films_not_90_minutes
FROM film
WHERE length > 90; /* Wynik: 675 */

/* Teraz wybiorę wszystkie filmy z wyjątkiem tych, 
które trwaja dokładnie 90 minut. */

SELECT title AS shorter_and_longer_90
FROM film
WHERE length <> 90;

/* Ile ich jest? */

SELECT COUNT(title) AS count_shorter_and_longer_90
FROM film
WHERE length <> 90; /* Wynik: 995 */

-- ==================================================
-- 9.1. WHERE - filtrowanie z tekstem
-- ==================================================

/* Wartości tekstowe zapisuje sie zawsze w pojedynczych apostrofach. */

SELECT *
FROM actor
WHERE first_name = 'John';

-- ==================================================
-- 9.2. WHERE - operatory
-- ==================================================

/*
> większy
< mniejszy
= równy
>= większy równy
<= miejszy równy
<> nie równy
*/ 

-- ==================================================
-- 9.3. WHERE i LIMIT
-- ==================================================

/* LIMIT wystepuje zawsze po WHERE. */

SELECT *
FROM actor
WHERE first_name = 'Nick'
LIMIT 2; /* W całej bazie jest 3 Nicków. */

-----------------------------------------------------