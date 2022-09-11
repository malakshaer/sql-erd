-- All the rooms that can seat at least 100 people
SELECT *
FROM rooms AS R
WHERE R.capacity > 99;

--All the room name that can seat at leat 100 people
SELECT R.name
FROM rooms AS R
WHERE R.capacity > 99;