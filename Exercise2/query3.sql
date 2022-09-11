--Find all courses taken by BIF majors
SELECT C.name
FROM courses AS C,departments AS D
WHERE D.name = 'BIF';