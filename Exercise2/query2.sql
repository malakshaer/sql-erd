--Find the course or courses(course name and code crn) with the earlies start time
SELECT C.name,start_time
FROM courses AS C
WHERE start_time IN (SELECT MIN(start_time)
                     FROM courses );