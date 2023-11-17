INSERT INTO
  person (
    id,
    first_name,
    last_name,
    social_security,
    address,
    email,
    phone
  )
VALUES
  (
    '0de9ef4b-a13a-4bce-a28b-902fa35040f3',
    'Juliana',
    'Kunze',
    '769183651',
    '94068 Patricia Mission',
    'Magnolia.Leannon21@gmail.com',
    '388-655-7741 x81868'
  );

INSERT INTO
  instructor (id, contact_person_id)
VALUES
  (
    '2eb49bd1-6068-4c9c-902d-ac4300abd56f',
    '0de9ef4b-a13a-4bce-a28b-902fa35040f3'
  );

INSERT INTO
  student (
    id,
    max_instrument_rent_amount,
    contact_person_id
  )
VALUES
  (
    '6ece213a-ce85-448f-a7a3-e1f5879dac2c',
    451,
    '0de9ef4b-a13a-4bce-a28b-902fa35040f3'
  );

INSERT INTO
  instrument_type (id, name)
VALUES
  (
    '3e0e0f0a-54c6-40ec-baf6-b150d7ebafc1',
    'Refined Cotton Chips'
  );

INSERT INTO
  price (id, class_type, level, sibling_discount, cost)
VALUES
  (
    'e5e039f9-e23d-4bd0-8498-2cacbc55cfa8',
    'Basic',
    'Beginner',
    3,
    341
  );

INSERT INTO
  time_slot (id, start_time, end_time)
VALUES
  (
    'd3f849f8-b887-4bd7-b6c9-ef4d34102a7f',
    '2023-11-16T09:12:51.271Z',
    '2023-11-17T15:27:59.353Z'
  );

INSERT INTO
  ensemble_lesson (
    id,
    level,
    min_students,
    max_students,
    genre,
    price_id,
    instructor_id,
    time_slot_id
  )
VALUES
  (
    '61f15435-285d-49de-b326-671d7b8b71f1',
    'Intermediate',
    1,
    21,
    'Funk',
    'e5e039f9-e23d-4bd0-8498-2cacbc55cfa8',
    '2eb49bd1-6068-4c9c-902d-ac4300abd56f',
    'd3f849f8-b887-4bd7-b6c9-ef4d34102a7f'
  );

INSERT INTO
  ensemble_lesson_student (id, ensemble_lesson_id, student_id, price, state)
VALUES
  (
    '34b0d786-d161-4ae2-afc8-ac28f852a08c',
    '61f15435-285d-49de-b326-671d7b8b71f1',
    '6ece213a-ce85-448f-a7a3-e1f5879dac2c',
    12,
    'active'
  );