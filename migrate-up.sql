CREATE TABLE "price"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "class_type" VARCHAR(256) NOT NULL,
  "level" VARCHAR(256) NOT NULL,
  "cost" INT NOT NULL
);

CREATE TABLE "student"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "first_name" VARCHAR(256) NOT NULL,
  "last_name" VARCHAR(256) NOT NULL,
  "social_security" VARCHAR(256) NOT NULL,
  "adress" VARCHAR(256) NOT NULL,
  "contact_details" VARCHAR(256) NOT NULL,
  "contact_person" VARCHAR(256) NOT NULL
);

CREATE TABLE "group_lesson"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "seats" INT NOT NULL,
  "level" VARCHAR(256) NOT NULL,
  "time_slot" TIMESTAMP NOT NULL,
  "min_students" INT NOT NULL,
  "max_students" INT NOT NULL,

  "price_id" uuid NOT NULL,
  CONSTRAINT fk_price_id FOREIGN KEY (price_id) REFERENCES "price"(id)

);

CREATE TABLE "ensemble_lesson"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "seats" INT NOT NULL,
  "level" VARCHAR(256) NOT NULL,
  "time_slot" TIMESTAMP NOT NULL,
  "min_students" INT NOT NULL,
  "max_students" INT NOT NULL,
  "genre" VARCHAR(256),

  "price_id" uuid NOT NULL,
  CONSTRAINT fk_price_id FOREIGN KEY (price_id) REFERENCES "price"(id)
);

CREATE TABLE "individual_lesson"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "appointment" TIMESTAMP NOT NULL,
  "level" VARCHAR(256) NOT NULL,

  "student_id" uuid NOT NULL,
  "price_id" uuid NOT NULL,
  CONSTRAINT fk_price_id FOREIGN KEY (price_id) REFERENCES "price"(id),
  CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES "student"(id)
);




CREATE TABLE "group_lesson_student"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "group_lesson_id" uuid NOT NULL,
  "student_id" uuid NOT NULL,
  "state" VARCHAR(256) NOT NULL,

  CONSTRAINT fk_group_lesson_id FOREIGN KEY (group_lesson_id) REFERENCES "group_lesson"(id),
  CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES "student"(id)
);

CREATE TABLE "ensemble_lesson_student"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ensemble_lesson_id" uuid NOT NULL,
  "student_id" uuid NOT NULL,
  "state" VARCHAR(256) NOT NULL,

  CONSTRAINT fk_ensemble_lesson_id FOREIGN KEY (ensemble_lesson_id) REFERENCES "ensemble_lesson"(id),
  CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES "student"(id)
);

