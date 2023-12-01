INSERT INTO historical_lesson (lesson_type, genre, instrument, price, student_name, student_email)
SELECT 
    'Individual Lesson' AS lesson_type,
    NULL AS genre,
    it.name AS instrument,
    ils.price AS price,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email AS student_email
FROM individual_lesson_student ils
JOIN individual_lesson il ON ils.individual_lesson_id = il.id
JOIN instrument_type it ON il.instrument_type_name = it.name
JOIN student s ON ils.student_id = s.id
JOIN time_slot ts on ts.id = il.time_slot_id 
where NOW() > ts.start_time

UNION

SELECT 
    'Group Lesson' AS lesson_type,
    NULL AS genre,
    it.name AS instrument,
    gls.price AS price,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email AS student_email
FROM group_lesson_student gls
JOIN group_lesson gl ON gls.group_lesson_id = gl.id
JOIN instrument_type it ON gl.instrument_type_name = it.name
JOIN student s ON gls.student_id = s.id
JOIN time_slot ts on ts.id = gl.time_slot_id 
where NOW() > ts.start_time

UNION

SELECT 
    'Ensemble Lesson' AS lesson_type,
    el.genre AS genre,
    NULL AS instrument,
    els.price AS price,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email AS student_email
FROM ensemble_lesson_student els
JOIN ensemble_lesson el ON els.ensemble_lesson_id = el.id
JOIN student s ON els.student_id = s.id
JOIN time_slot ts on ts.id = el.time_slot_id 
where NOW() > ts.start_time;