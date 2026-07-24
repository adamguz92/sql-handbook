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

/* Przy użyciu funkcji agregujących (np. MAX()) 
otrzymam wynik z domyślnym aliasem od nazwy funkcji.
Przykładowo: */

SELECT MAX(length)
FROM film;

/* Więc jeżeli w jednym zapytaniu użyje dwókrotnie tej samej funkcji,
otrzymam nakładające się na siebie domyślne aliasy. 
Aby to rozwiązać użyj aliasów do każdej funkcji agregującej. */

SELECT
    MAX(length) AS max_length,
    MAX(rental_duration) AS max_rental_duration
FROM film;

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
3. GROUP BY - działa na danych przefiltrowanych przez WHERE
4. HAVING
5. SELECT (Tutaj są dodawane aliasy)
6. ORDER BY
7. LIMIT
 
*/

/* Zwróć uwagę, że komenda WHERE jest wykonywane przed SELECT,
dlatego odwołanie się do aliasu w funkcji WHERE nie jest możliwe.
Poniższy kod zwróci błąd, ponieważ nie odnajdzie zmiennej o nazwie dlugosc. */

SELECT length AS dlugosc
FROM film
WHERE dlugosc >= 90;

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

-- ==================================================
-- 10. OR, AND, BETWEEN
-- ==================================================

/* Podgląd danych */

SELECT *
FROM film
LIMIT 10;

/* BEETWEEN, OR i AND uwzględniają liczbowe wartości graniczne. */

-- ==================================================
-- 10.1. OR
-- ==================================================

SELECT title, length
FROM film
WHERE length = 90 OR length = 170;

/* Wyświetli wszystkie tytuł, trwają 90 lub 170 minut.
Zwróć uwagę na zapis nazwy zmiennej length dwukrotnie w połączeniu z OR.
Taki zapis jest wymagany przez SQL. */

-- ==================================================
-- 10.2. AND
-- ==================================================

/* Wybór filmów trwających minimum 90 minut z 2006 roku */

SELECT title, length, release_year
FROM film
WHERE length >= 90 AND release_year = 2006;

/* Ile jest filmów spełniających te kryteria? 
Przypomnienie użycia COUNT(). */

SELECT COUNT(title)
FROM film
WHERE length >= 90 AND release_year = 2006; /* Wynik: 680 */

-- ==================================================
-- 10.3. BETWEEN
-- ==================================================

SELECT title, length
FROM film
WHERE length BETWEEN 90 AND 100; 
/* Z wartościami 90 i 100 włącznie. */

-- ==================================================
-- 10.4. AND, OR
-- ==================================================

SELECT title, length, release_year
FROM film
WHERE (length = 90 OR length = 100) 
    AND (release_year = 2005 OR release_year = 2006);

/*
Jeżeli w jednym zapytaniu łączysz operatory
AND oraz OR, warto używać nawiasów,
aby jednoznacznie określić kolejność
wykonywania warunków.
*/

-- ==================================================
-- 10.5. BETWEEN, AND, AND
-- ==================================================

/* Konstrukcja z BETWEEN, AND, AND */

SELECT title, length, release_year
FROM film
WHERE length
BETWEEN 90 AND 120 AND release_year = 2006;

-----------------------------------------------------

-- ==================================================
-- 11. LIKE, NOT LIKE, OR, IN, %, _
-- ==================================================

/* LIKE, NOT LIKE służą do filtrowania tekstu .
Operator IN pozwala sprawdzić, czy wartość należy do określonego zbioru (tekst, liczby lub daty). */

/* % zastępuje wiele znaków, np. Ad%,
_ zastępuje jeden brakujący znak, np. Ada_.*/

-- ==================================================
-- 11.1. Najczęściej używane wzorce % i _
-- ==================================================

/*

'A%'   - zaczyna się od A

'%A'   - kończy się na A

'%A%'  - zawiera literę A

'A_A'  - zaczyna się od A,
         następnie dowolny znak,
         a potem A
*/

-- ==================================================
-- 11.2. LIKE z operatorem % i _
-- ==================================================

/* Najpierw podejrzę dane. */

SELECT first_name
FROM actor
WHERE first_name LIKE 'J%'; /* Wynik: imiona zaczynające się na J. */

SELECT first_name
FROM actor
WHERE first_name LIKE 'Juli_'; /* Wynik: Julia */

SELECT first_name
FROM actor
WHERE first_name LIKE '__rist%er'; /* Wynik: Christopher */

SELECT first_name
FROM actor
WHERE first_name LIKE '%a%'; /* Wynik: imiona, 
która zawierają a, ale nie w pierwszej i ostatniej literze. */

-- ==================================================
-- 11.3. NOT LIKE z operatorem % i _
-- ==================================================

SELECT first_name
FROM actor
WHERE first_name NOT LIKE 'Julia'; 
/* Wynik: wszystkie imiona w kolumnie, bez imienia Julia. */

SELECT first_name
FROM actor
WHERE first_name NOT LIKE 'Juli_'; 
/* Wynik: wszystkie imiona w kolumnie, bez imienia Julia. */

SELECT first_name
FROM actor
WHERE first_name NOT LIKE 'J%'; 
/* Wynik: wszystkie imiona w kolumnie, bez imion zaczynających się na J. */

SELECT first_name
FROM actor
WHERE first_name NOT LIKE '%a';
/* Wynik: wszystkie imiona w kolumnie, bez imion zakończonych na literę a. */

-- ==================================================
-- 11.4. OR
-- ==================================================

/* OR pozwala wybrać wiele wyników. */

SELECT title, length
FROM film
WHERE length = 90 
OR length = 100
OR length = 120
OR length = 180; 
/* Wynik: filmy, które trwają 90, 100, 120 i 180 minut. */

-- ==================================================
-- 11.5. IN (OR vs IN)
-- ==================================================

/* Operator IN pozwala wybrać kilka wartości. 
Jest to bardziej czytelny i wygodniejszy sposób zapisu wielu warunków niż użycie kilku operatorów OR. */

SELECT title, length
FROM film
WHERE length IN (90, 100, 120, 180);
/* Wynik: filmy, które trwają 90, 100, 120 i 180 minut. */

-----------------------------------------------------

-- ==================================================
-- 12. Braki danych
-- ==================================================

/* null = missing value

COUNT(*) - zliczy wszystkie rekordy, z pustymi włącznie
COUNT(first_name) - zliczy tylko wypełnione (niezerowe rekordy). */

/* Podglądam dane. */

SELECT *
FROM film;

/* Sprawdzam ile jest wszystkich rekordów. */

SELECT COUNT(*) AS count_records
FROM film; /* Wynik: 200 */

-- ==================================================
-- 12.1. IS NULL
-- ==================================================

/* Sprawdzenie czy kolumna ma braki w danych. */

SELECT title AS no_length
FROM film
WHERE length IS NULL; /* Wynik: 0 */

-- ==================================================
-- 12.2. IS NOT NULL
-- ==================================================

/* Zliczenie niepustych rekordów. */

SELECT COUNT(title) AS count_length
FROM film
WHERE length IS NOT NULL;

-- ==================================================
-- 12.3. COUNT() vs IS NOT NULL
-- ==================================================

SELECT COUNT(length) AS count_length
FROM film;

SELECT COUNT(length) AS count_length
FROM film
WHERE length IS NOT NULL;

/* Dwa powyższe query są sobie równe. Zwrócą ten sam wynik. */

-----------------------------------------------------

-- ==================================================
-- 13. AVG(), SUM(), MIN(), MAX(), COUNT()
-- ==================================================

/* To funkcje służące do statystycznego podsumowania danych. */

-- ==================================================
-- 13.1. AVG()
-- ==================================================

/* Średnia długość trwania filmu */

SELECT AVG(length) AS avg_length
FROM film;

-- ==================================================
-- 13.2. SUM()
-- ==================================================

/* Całkowita długość filmów wyprodukowanych w 2006 r. */

SELECT SUM(length) AS sum_length_2006
FROM film
WHERE release_year = 2006;

-- ==================================================
-- 13.3. MIN()
-- ==================================================

/* Najkrótszy film w 2006 r. */

SELECT MIN(length)
FROM film
WHERE release_year = 2006;

-- ==================================================
-- 13.4. MAX()
-- ==================================================

/* Najdłuższy film z 2006 r. */

SELECT MAX(length)
FROM film
WHERE release_year = 2006;

-- ==================================================
-- 13.5. MIN(), MAX() z wartościami nienumerycznymi 
-- ==================================================

/* Funkcje AVG() i SUM() są używane tylko z wartościami liczbowymi.
Funkcji MIN(), MAX() i COUNT() można używać z różnymi typami wartości.
W przypadku wartości tekstowych kolejności będzie oparta na alfabecie. 
W przypadku daty będzie to data od najwcześniejszej do najpóźniejszej. */

SELECT MIN(first_name)
FROM actor;

SELECT MAX(first_name)
FROM actor;

-- ==================================================
-- 13.6. COUNT() w podsumowaniu danych
-- ==================================================

SELECT COUNT(first_name)
FROM actor; /* Zliczy tylko wypełnione (niezerowe) rekordy. */

-----------------------------------------------------

-- ==================================================
-- 14. ROUND()
-- ==================================================

/* Służy do zaokrąglania. */

SELECT ROUND(AVG(length), 2) AS avg_round
FROM film; /* Zaokrąglenie do 2 miejsc po przecinku. */

SELECT ROUND(AVG(length)) AS avg_round
FROM film; /* Zaokrąglenie do liczb całkowitych. */

-----------------------------------------------------

-- ==================================================
-- 15. Arytmetyka
-- ==================================================

/* Dodawanie */

SELECT(4 + 3);

/* Odejmowanie */
SELECT(4 - 3);

/* Mnożenie */
SELECT(4 * 3);

/* Dzielenie */
SELECT(4 / 3); /* Wynik: 1 */

/* Powyższy zapis nie jest w SQL precyzyjny. 
Prawidłowy wynik otrzymam używając tego zapisu: */

SELECT (4.0 / 3.0); /* Wynik: 1.33 */

/* WAŻNE
Funkcje agregujące tj. np. AVG(), SUM() działają NA KOLUMNACH.
Arytmetyk w SQL operuje na wierszach. */

/* Ten kod nie ma sensu,
ale ilustruje działanie arytmetyki rekordach wierszy. */

SELECT title, (length - rental_rate) AS length_minu_rental_rate
FROM film;

-----------------------------------------------------

-- ==================================================
-- 16. ORDER BY - sortowanie rezultatów
-- ==================================================

/* Sortowanie wynikówpo wskazanej zmiennej tekstowej */

SELECT first_name, last_name
FROM actor
ORDER BY first_name;

/* Sortowanie wyników po wskazanej zmiennej liczbowej */

SELECT title, length
FROM film
ORDER BY length;

-- ==================================================
-- 16.1. ORDER BY, ASC, DESC - sortowanie rosnąco i malejąco
-- ==================================================

/* ORDER BY domyślnie sortuje rosnąco. */ 

/* Sortowanie wyników rosnąco po wybranej zmiennej */

SELECT title, length 
FROM film
ORDER BY length ASC;

/* Sortowanie rekordów malejąco po wybranej zmiennej */

SELECT title, length 
FROM film
ORDER BY length DESC;

-- ==================================================
-- 16.2. ORDER BY - sortowanie po wielu zmiennych
-- ==================================================

/* Rekordy są sortowane najpierw według pierwszej zmiennej podanej w zapytanie (length),
następnie sortowana jest druga podana w kolejności zmienna (rental_rate). */

SELECT title, length, rental_rate
FROM film
ORDER BY length ASC, rental_rate ASC;

-- ==================================================
-- 16.3. ORDER BY - sortowanie po wielu zmiennych z WHERE
-- ==================================================

/*
Najpierw wykonywany jest filtr WHERE,
dopiero później wyniki są sortowane przez ORDER BY.
*/

SELECT title, length, rental_rate
FROM film
WHERE length >= 90
ORDER BY length ASC, rental_rate ASC;

-----------------------------------------------------

-- ==================================================
-- 17. GROUP BY - grupowanie danych
-- ==================================================

/* Podgląd danych */

SELECT *
FROM film
LIMIT 10;

/* Pogrupuje dane po zmiennej rental_rate 
i sprawdzę jaka jest liczebność każdej grupy. */

SELECT rental_rate, COUNT(title) AS title_count
FROM film
GROUP BY rental_rate;

-- ==================================================
-- 17.1. GROUP BY i ORDER BY - grupowanie wielu zmiennych 
-- ==================================================

/* Grupowanie po dwóch zmiennych, 
ze zliczeniem tytułów w każdej kategorii. */

SELECT rental_rate, rating, COUNT(title) AS title_count
FROM film
GROUP BY rental_rate, rating
ORDER BY rental_rate DESC;

-- ==================================================
-- 18. HAVING - filtrowanie pogrupowanych danych
-- ==================================================

/* HAVING filtruje pogrupowane rekordy, 
w przeciwieństwie do WHERE, które filtruje pojedyncze obserwacje. */

/* 
WHERE filtruje pojedyncze rekordy przed grupowaniem.

HAVING filtruje całe grupy utworzone przez GROUP BY.
Poniższy kod zwróci error: */

SELECT rental_rate, rating, COUNT(title) AS title_count
FROM film
WHERE COUNT(title) > 10
GROUP BY rental_rate, rating;

/* Natomiast jeżeli użyje HAVING zamiast WHERE kod zadziała: */

SELECT rental_rate, rating, COUNT(title) AS title_count
FROM film
GROUP BY rental_rate, rating
HAVING COUNT(title) >= 70;

-- ==================================================
-- 19. 
-- ==================================================

/* Podgląd danych */

SELECT *
FROM states
LIMIT 5;