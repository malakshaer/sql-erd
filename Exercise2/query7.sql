--Find the number of majors that each student has declared
SELECT COUNT( DISTINCT D.name)
FROM departments AS D;