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
and EXTRACT(year  FROM NOW()) = EXTRACT(Year FROM ts.start_time) -- change the left hand side to any year
GROUP BY
  TO_CHAR(ts.start_time, 'Mon')
ORDER BY
  TO_CHAR(ts.start_time, 'Mon');

 --EXPLAIN ANALYZE

-- QUERY 2
SELECT 
    NumberOfSiblings as "No of siblings",
    COUNT(*) AS "No of students"
FROM 
    (SELECT 
         s.id,
         COUNT(sibling.student_1) AS NumberOfSiblings
     FROM 
         student s 
     LEFT JOIN 
         sibling ON s.id = sibling.student_1
     GROUP BY 
         s.id)
GROUP BY 
    NumberOfSiblings
ORDER BY 
    NumberOfSiblings;

--EXPLAIN ANALYZE

-- QUERY 3
SELECT
    i.id AS "Instructor Id",
    i.first_name AS "First Name",
    i.last_name AS "Last Name",
    COUNT(*) AS "No of Lessons"
FROM
    instructor i
    JOIN (
        SELECT il.instructor_id
        FROM individual_lesson il
        JOIN time_slot ts ON il.time_slot_id = ts.id
        WHERE EXTRACT(MONTH FROM NOW()) = EXTRACT(MONTH FROM ts.start_time)
        
        UNION ALL
        
        SELECT gl.instructor_id
        FROM group_lesson gl
        JOIN time_slot ts ON gl.time_slot_id = ts.id
        WHERE EXTRACT(MONTH FROM NOW()) = EXTRACT(MONTH FROM ts.start_time)

        
        UNION ALL
        
        SELECT el.instructor_id
        FROM ensemble_lesson el
        JOIN time_slot ts ON el.time_slot_id = ts.id
        WHERE EXTRACT(MONTH FROM NOW()) = EXTRACT(MONTH FROM ts.start_time)

    ) AS all_lessons ON i.id = all_lessons.instructor_id
GROUP BY
    i.id,
    i.first_name,
    i.last_name
HAVING
    COUNT(*) > 0 
ORDER BY
    COUNT(*) DESC;
  

--EXPLAIN ANALYZE

-- QUERY 4
select 
to_char(ts.start_time, 'Day') as "day",
RemainingTable.genre as Genre,
case
	when(RemainingTable.numberofstudents = 0) then 'No Seats'
	when(RemainingTable.numberofstudents = 1 or RemainingTable.numberofstudents = 2) then '1 or 2 Seats'
	else 'Many Seats'
end as "Remaining seats"


from
(SELECT 
	l.time_slot_id,
    l.id, 
    l.genre,
    (l.max_students - COUNT(els.student_id)) AS NumberOfStudents
FROM ensemble_lesson AS l
JOIN ensemble_lesson_student AS els ON l.id = els.ensemble_lesson_id
GROUP BY l.id) as RemainingTable


left join time_slot ts on ts.id = RemainingTable.time_slot_id
WHERE ts.start_time BETWEEN NOW() AND NOW() + INTERVAL '1 week'
group by to_char(ts.start_time, 'Day'), RemainingTable.genre, RemainingTable.numberofstudents
order by to_char(ts.start_time, 'Day') desc;
   