--Find the course or courses(course name and code crn) with the earlies start time
SELECT C.crn,C.name,MIN(start_time)
FROM courses AS C;