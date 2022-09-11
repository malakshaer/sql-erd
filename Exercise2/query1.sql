--All the room name that can seat at leat 100 people
SELECT R.name
FROM rooms AS R
WHERE R.capacity > 99;