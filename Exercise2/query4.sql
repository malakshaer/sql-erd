--Create a list of all students who are not enrolled in a course
SELECT S.name 
FROM students AS S,enrolleds AS E
WHERE E.credit_status = 0;