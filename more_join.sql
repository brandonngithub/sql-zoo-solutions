-- 1) 1962 movies
SELECT
    id,
    title
FROM
    movie
WHERE
    yr = 1962;

-- 2) When was Citizen Kane released?
SELECT
    yr
FROM
    movie
WHERE
    title = 'Citizen Kane';

-- 3) Star Trek movies
SELECT
    id,
    title,
    yr
FROM
    movie
WHERE
    title LIKE '%Star Trek%'
ORDER BY
    yr;

-- 4) id for actor Glenn Close
SELECT
    id
FROM
    actor
WHERE
    name = 'Glenn Close';

-- 5) id for Casablanca
SELECT
    id
FROM
    movie
WHERE
    title = 'Casablanca';

-- 6) Cast list for Casablanca
SELECT
    name
FROM
    actor
    JOIN casting ON (id = actorid)
WHERE
    movieid = 11768;

-- 7) Alien cast list
SELECT
    name
FROM
    actor
    JOIN casting ON (id = actorid)
WHERE
    movieid = (
        SELECT
            id
        FROM
            movie
        WHERE
            title = 'Alien'
    );

-- 8) Harrison Ford movies
SELECT
    title
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (actor.id = casting.actorid)
WHERE
    name = 'Harrison Ford';

-- 9) Harrison Ford as a supporting actor
SELECT
    title
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (actor.id = casting.actorid)
WHERE
    name = 'Harrison Ford'
    AND ord != 1;

-- 10) Lead actors in 1962 movies
SELECT
    title,
    name
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (actor.id = casting.actorid)
WHERE
    ord = 1
    AND yr = 1962;

-- 11) Busy years for Rock Hudson
SELECT
    yr,
    COUNT(title)
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    name = 'Rock Hudson'
GROUP BY
    yr
HAVING
    COUNT(title) > 2;

-- 12) Lead actor in Julie Andrews movies
SELECT
    title,
    name
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    ord = 1
    AND movieid IN (
        SELECT
            movieid
        FROM
            casting
        WHERE
            actorid IN (
                SELECT
                    id
                FROM
                    actor
                WHERE
                    name = 'Julie Andrews'
            )
    );

-- 13) Actors with 15 leading roles
SELECT
    name
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    ord = 1
GROUP BY
    name
HAVING
    COUNT(ord) >= 15;

-- 14) released in the year 1978
SELECT
    title,
    COUNT(name)
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    yr = 1978
GROUP BY
    title
ORDER BY
    COUNT(name) DESC,
    title;

-- 15) with 'Art Garfunkel'
SELECT
    name
FROM
    actor
    JOIN casting ON (actor.id = casting.actorid)
WHERE
    movieid IN (
        SELECT
            movieid
        FROM
            actor
            JOIN casting ON (actor.id = casting.actorid)
        WHERE
            name = 'Art Garfunkel'
    )
    AND name != 'Art Garfunkel';
