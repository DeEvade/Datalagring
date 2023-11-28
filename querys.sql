--EXPLAIN ANALYZE

-- QUERY 1
SELECT
  TO_CHAR(ts.start_time, 'Mon') AS Month,
  COUNT(ts.id) AS "Total",
  COUNT(il.id) AS "Individual",
  COUNT(gl.id) AS "Group",
  COUNT(el.id) AS "Ensemble"
FROM
  time_slot ts
LEFT JOIN individual_lesson il ON ts.id = il.time_slot_id
LEFT JOIN group_lesson gl ON ts.id = gl.time_slot_id
LEFT JOIN ensemble_lesson el ON ts.id = el.time_slot_id
WHERE ts.id NOT IN (SELECT time_slot_id FROM instrument i WHERE time_slot_id = i.time_slot_id)
GROUP BY
  TO_CHAR(ts.start_time, 'Mon')
ORDER BY
  TO_CHAR(ts.start_time, 'Mon');

-- QUERY 2
SELECT 
 	AS "No of Siblings"
 	count() AS "No of Students"
FROM 
	sibling s 
LEFT JOIN student st ON st.id = s.student_1 AND st.id = s.student_2 

GROUP BY

ORDER by 

-- QUERY 3
SELECT
    i.id AS "Instructor Id",
    i.first_name AS "First Name",
    i.last_name AS "Last Name",
    COUNT(*) AS "No of Lessons"
FROM
    instructor i
JOIN (
    SELECT instructor_id FROM individual_lesson
    UNION ALL
    SELECT instructor_id FROM group_lesson
    UNION ALL
    SELECT instructor_id FROM ensemble_lesson
) AS all_lessons ON i.id = all_lessons.instructor_id -- sätter ihop alla lektioner till en lektion på instructorns id, vi behlver inte veta vilken lekton som arbetades på
GROUP BY
    i.id, i.first_name, i.last_name
HAVING
    COUNT(*) > 0
ORDER BY
    count(*)  DESC;

-- QUERY 4
SELECT 
    TO_CHAR(ts.start_time, 'Day') AS day,
    el.genre AS Genre,
    CASE
        WHEN (
            SELECT COUNT(*)
            FROM ensemble_lesson_student els
            WHERE el.id = els.ensemble_lesson_id
        ) BETWEEN 1 AND 2 THEN '1 or 2 seats'
        WHEN (
            SELECT COUNT(*)
            FROM ensemble_lesson_student els
            WHERE el.id = els.ensemble_lesson_id
        ) > 2 THEN 'Many seats'
        ELSE 'No seats'
    END AS "No of Free Seats"
FROM 
    ensemble_lesson el 
LEFT JOIN time_slot ts ON ts.id = el.time_slot_id
GROUP BY 
    TO_CHAR(ts.start_time, 'Day'), el.genre, el.id
ORDER BY 
    TO_CHAR(ts.start_time, 'Day') DESC;



select
TO_CHAR(ts.start_time, 'Day') AS day,
el.genre as "Genre",
COUNT(*)
from 
ensemble_lesson_student els
left join ensemble_lesson el on el.id = els.ensemble_lesson_id
left join time_slot ts on ts.id = el.time_slot_id
where el.id = els.ensemble_lesson_id
GROUP BY 
    TO_CHAR(ts.start_time, 'Day'), el.genre
ORDER BY 
    TO_CHAR(ts.start_time, 'Day') DESC;
   