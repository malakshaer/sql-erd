--Find the number of CS students enrolled in any course
SELECT COUNT(S.name)
FROM students AS S,enrolleds AS E,departments AS D
WHERE E.credit_status = 0 AND D.name = 'CS';