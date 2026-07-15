-- ==================================================
-- SQL HANDBOOK
-- ==================================================

-- Author: Adam Guz
-- Last update: 2026-07-15

-- ==================================================
-- 1. SELECT
-- ==================================================

/* 
Cel

SELECT służy do wybierania kolumn z tabel. 
*/


-- ==================================================
-- 1.1 SELECT kolumna
-- ==================================================

/*
Cel

SELECT [nazwa kolumny] służy do wybierania określonych kolumn z tabeli.
*/

SELECT
    first_name,
    last_name
FROM
    actor;

------------------------------------------------------

-- ==================================================
-- 1.2 SELECT *
-- ==================================================

/*
Cel

* służy do wybierania wszystkich kolumn z tabeli.
*/

SELECT
    *
FROM
    actor;

------------------------------------------------------

SELECT
    first_name,
    last_name
FROM
    actor
LIMIT 10;
    