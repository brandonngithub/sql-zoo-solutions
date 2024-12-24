-- 1)
SELECT
    COUNT(id)
FROM
    stops;

-- 2)
SELECT
    id
FROM
    stops
WHERE
    name = 'Craiglockhart';

-- 3)
SELECT
    id,
    name
FROM
    stops
    JOIN route ON (stops.id = route.stop)
WHERE
    num = '4'
    AND company = 'LRT';

-- 4) Routes and stops
SELECT
    company,
    num,
    COUNT(*)
FROM
    route
WHERE
    stop = 149
    OR stop = 53
GROUP BY
    company,
    num
HAVING
    COUNT(*) = 2;

-- 5)
SELECT
    a.company,
    a.num,
    a.stop,
    b.stop
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
WHERE
    a.stop = 53
    AND b.stop = 149;

-- 6)
SELECT
    a.company,
    a.num,
    stopa.name,
    stopb.name
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON (a.stop = stopa.id)
    JOIN stops stopb ON (b.stop = stopb.id)
WHERE
    stopa.name = 'Craiglockhart'
    AND stopb.name = 'London Road';

-- 7) Using a self join
SELECT DISTINCT
    a.company,
    a.num
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
WHERE
    a.stop = 115
    AND b.stop = 137;

-- 8)
SELECT
    a.company,
    a.num
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON (a.stop = stopa.id)
    JOIN stops stopb ON (b.stop = stopb.id)
WHERE
    stopa.name = 'Craiglockhart'
    AND stopb.name = 'Tollcross';

-- 9)
SELECT
    stopb.name,
    a.company,
    a.num
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON (a.stop = stopa.id)
    JOIN stops stopb ON (b.stop = stopb.id)
WHERE
    stopa.name = 'Craiglockhart';

-- 10)
SELECT
    a.num,
    a.company,
    a.name,
    b.num,
    b.company
FROM
    (
        SELECT
            stopa.name,
            a.num,
            a.company
        FROM
            route a
            JOIN route b ON (
                a.company = b.company
                AND a.num = b.num
            )
            JOIN stops stopa ON (a.stop = stopa.id)
            JOIN stops stopb ON (b.stop = stopb.id)
        WHERE
            stopb.name = 'Craiglockhart'
    ) AS a
    JOIN (
        SELECT
            stopa.name,
            a.num,
            a.company
        FROM
            route a
            JOIN route b ON (
                a.company = b.company
                AND a.num = b.num
            )
            JOIN stops stopa ON (a.stop = stopa.id)
            JOIN stops stopb ON (b.stop = stopb.id)
        WHERE
            stopb.name = 'Lochend'
    ) AS b ON (a.name = b.name)
ORDER BY
    a.num,
    a.name,
    b.num;
