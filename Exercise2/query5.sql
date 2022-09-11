--Find the number of CS students enrolled in  CSC275 
SELECT COUNT(S.name)
FROM students AS S,enrolleds AS E,departments AS D
WHERE E.course_crn ='CSC275' AND D.name = 'CS';