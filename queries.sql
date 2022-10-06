-- write your queries here
-- Join the two tables so that every column and record appears, regardless of if there is not an owner_id --
SELECT * 
FROM owners o
FULL JOIN vehicles v
ON o.id = v.owner_id;

-- Count the number of cars for each owner. Display the owners first_name, last_name and count of vehicles. --
-- The first_name should be ordered in ascending order.  --

SELECT o.first_name, o.last_name, COUNT(v.id) AS count
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY o.id
ORDER BY count ASC;

-- Count the number of cars for each owner and display the average price for each of the cars as integers. --
-- Display the owners first_name, last_name, average price and count of vehicles. --
-- The first_name should be ordered in descending order. --
-- Only display results with more than one vehicle and an average price greater than 10000. --

SELECT o.first_name, o.last_name, ROUND(AVG(v.price)) AS average_price, COUNT(v.id) AS count
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY o.id
HAVING AVG(v.price) > 10000
ORDER BY o.first_name DESC;


-- SQL ZOO JOIN https://sqlzoo.net/wiki/The_JOIN_operation --
-- 1
SELECT * FROM goal 
WHERE player LIKE '%Bender';

-- 2
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012;

-- 3
SELECT p.player, p.teamid, g.stadium, g.mdate
FROM game g JOIN goal p ON (g.id=p.matchid)
WHERE p.teamid = 'GER';

-- 4
SELECT g.team1, g.team2, p.player
FROM game g JOIN goal p ON (g.id=p.matchid)
WHERE p.player LIKE '%Mario%';

-- 5
SELECT p.player, p.teamid, t.coach, p.gtime
FROM goal p JOIN eteam t ON (p.teamid = t.id)
WHERE gtime<=10;

-- 6
SELECT g.mdate, t.teamname
FROM game g JOIN eteam t ON g.team1 = t.id
WHERE t.coach = 'Fernando Santos';

-- 7
SELECT p.player
FROM goal p JOIN game g ON p.matchid = g.id
WHERE g.stadium = 'National Stadium, Warsaw';

-- 8
SELECT p.player
FROM goal p JOIN game g ON p.matchid = g.id 
WHERE (g.team1='GER' OR g.team2='GER') AND p.teamid != 'GER'
GROUP BY p.player
ORDER BY p.player;

-- 9
SELECT t.teamname, COUNT(p.teamid) AS count
FROM eteam t JOIN goal p ON t.id=p.teamid
GROUP BY t.teamname
ORDER BY count DESC;

-- 10
SELECT g.stadium, COUNT(g.stadium) AS count
FROM game g JOIN goal p ON g.id = p.matchid
GROUP BY g.stadium
ORDER BY count DESC;

-- 11
SELECT p.matchid, g.mdate, COUNT(p.matchid)
FROM game g JOIN goal p ON g.id = p.matchid
WHERE (g.team1 = 'POL' OR g.team2 = 'POL')
GROUP BY p.matchid, g.mdate;

-- 12
SELECT p.matchid, g.mdate, COUNT(p.matchid)
FROM game g JOIN goal p ON g.id = p.matchid
WHERE (g.team1 = 'GER' OR g.team2 = 'GER') AND p.teamid = 'GER'
GROUP BY p.matchid, g.mdate;

-- 13
SELECT g.mdate, 
g.team1,
SUM (CASE WHEN p.teamid=g.team1 THEN 1 ELSE 0 END) AS score1, 
g.team2, 
SUM (CASE WHEN p.teamid=g.team2 THEN 1 ELSE 0 END) AS score2
FROM game g JOIN goal p ON g.id = p.matchid
GROUP BY g.mdate, p.matchid, g.team1, g.team2
ORDER BY g.mdate, p.matchid, g.team1, g.team2;

-- SQL ZOO MORE JOIN https://sqlzoo.net/wiki/More_JOIN_operations --
-- 1
SELECT id, title
FROM movie
WHERE yr=1962;

-- 2
SELECT m.yr
FROM movie m
WHERE m.title = 'Citizen Kane';

-- 3
SELECT m.id, m.title, m.yr
FROM movie m
WHERE m.title LIKE '%Star Trek%';

-- 4
SELECT a.id
FROM actor a
WHERE a.name = 'Glenn Close';

-- 5
SELECT m.id 
FROM movie m
WHERE m.title = 'Casablanca';

-- 6
SELECT a.name
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE m.title = 'Casablanca';

-- 7
SELECT a.name
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE m.title = 'Alien';

-- 8
SELECT m.title
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE a.name = 'Harrison Ford';

-- 9
SELECT m.title
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE a.name = 'Harrison Ford' AND c.ord != 1;

-- 10
SELECT m.title, a.name
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE m.yr = 1962 AND c.ord = 1;

-- 11
SELECT yr,COUNT(title) 
FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name='Doris Day'
GROUP BY yr
HAVING COUNT(title) > 1;

-- 12
SELECT m.title, a.name
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE c.movieid IN (
SELECT c.movieid FROM casting c
WHERE c.actorid IN (
SELECT a.id FROM actor a
WHERE a.name = 'Julie Andrews')) AND c.ord = 1;

-- 13
SELECT a.name
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE c.ord = 1
GROUP BY a.name
HAVING COUNT(a.name) >= 15
ORDER BY a.name;

-- 14
SELECT m.title, COUNT(a.name) AS number_of_actors
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE m.yr = 1978
GROUP BY m.title
ORDER BY number_of_actors DESC, m.title;

-- 15
SELECT a.name
FROM actor a 
JOIN casting c ON a.id = c.actorid
JOIN movie m ON c.movieid = m.id
WHERE c.movieid IN (
SELECT c.movieid FROM casting c
WHERE c.actorid IN (
SELECT a.id FROM actor a
WHERE a.name = 'Art Garfunkel')) AND a.name != 'Art Garfunkel';