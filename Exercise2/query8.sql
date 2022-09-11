--For each department with more than one majoring student, print the 
--department’s name and the number of majoring students

SELECT DISTINCT D.name,COUNT(S.name) > 1 
FROM departments AS D,students AS S,enrolleds AS E
WHERE E.credit_status > 0 GROUP BY S.name;