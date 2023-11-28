CREATE TABLE "price"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "class_type" VARCHAR(256) NOT NULL,
  "level" VARCHAR(256) NOT NULL,
  "sibling_discount" INT not NULL,
  "cost" INT NOT NULL
);

CREATE TABLE "time_slot"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "start_time" TIMESTAMP NOT NULL,
  "end_time" TIMESTAMP NOT NULL
);

CREATE TABLE "contact_person"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "first_name" VARCHAR(256) NOT NULL,
  "last_name" VARCHAR(256) NOT NULL,
  "social_security" VARCHAR(256) UNIQUE NOT NULL,
  "address" VARCHAR(256) NOT NULL,
  "email" VARCHAR(256) UNIQUE NOT NULL,
  "phone" VARCHAR(256) UNIQUE NOT NULL
);

CREATE TABLE "student"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "first_name" VARCHAR(256) NOT NULL,
  "last_name" VARCHAR(256) NOT NULL,
  "social_security" VARCHAR(256) UNIQUE NOT NULL,
  "address" VARCHAR(256) NOT NULL,
  "email" VARCHAR(256) UNIQUE NOT NULL,
  "phone" VARCHAR(256) UNIQUE NOT NULL, -- Here a comma sign was forgotten and added later
  "contact_person_id" uuid,
  CONSTRAINT fk_contact_person_id FOREIGN KEY (contact_person_id) REFERENCES "contact_person"(id) ON DELETE CASCADE
);

CREATE TABLE "sibling"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "student_1" uuid NOT NULL,
  "student_2" uuid NOT NULL,
  CONSTRAINT fk_student_1 FOREIGN KEY (student_1) REFERENCES "student"(id) ON DELETE CASCADE,
  CONSTRAINT fk_student_2 FOREIGN KEY (student_2) REFERENCES "student"(id) ON DELETE CASCADE
);

CREATE TABLE "instrument_type"("name" VARCHAR(256) PRIMARY KEY NOT NULL);

CREATE TABLE "instrument"(
  "id" uuid primary key default gen_random_uuid(),
  "price" INT NOT NULL,
  "instrument_type_name" VARCHAR(256) NOT NULL,
  CONSTRAINT fk_instrument_type_name FOREIGN KEY (instrument_type_name) REFERENCES "instrument_type"("name") ON DELETE CASCADE,
  "student_id" uuid,
  CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES "student"(id) ON DELETE CASCADE,
  "time_slot_id" uuid,
  CONSTRAINT fk_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES "time_slot"(id) ON DELETE CASCADE
);


CREATE TABLE "instructor"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "first_name" VARCHAR(256) NOT NULL,
  "last_name" VARCHAR(256) NOT NULL,
  "social_security" VARCHAR(256) UNIQUE NOT NULL,
  "address" VARCHAR(256) NOT NULL,
  "email" VARCHAR(256) UNIQUE NOT NULL,
  "phone" VARCHAR(256) UNIQUE NOT NULL, -- Here a comma sign was forgotten and added later
  "contact_person_id" uuid,
  CONSTRAINT fk_contact_person_id FOREIGN KEY (contact_person_id) REFERENCES "contact_person"(id) ON DELETE CASCADE
);

CREATE TABLE "group_lesson"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "level" VARCHAR(256) NOT NULL,
  "min_students" INT NOT NULL,
  "max_students" INT NOT NULL,
  "price_id" uuid NOT NULL,
  "instructor_id" uuid NOT NULL,
  "instructor_pay" INT not null, 
  "instrument_type_name" VARCHAR(256) NOT NULL,
  CONSTRAINT fk_instrument_type_name FOREIGN KEY (instrument_type_name) REFERENCES "instrument_type"("name") ON DELETE CASCADE,
  CONSTRAINT fk_instructor_id FOREIGN KEY (instructor_id) REFERENCES "instructor"(id) ON DELETE CASCADE,
  CONSTRAINT fk_price_id FOREIGN KEY (price_id) REFERENCES "price"(id) ON DELETE CASCADE,
  "time_slot_id" uuid NOT NULL,
  CONSTRAINT fk_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES "time_slot"(id) ON DELETE CASCADE
);

CREATE TABLE "ensemble_lesson"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "level" VARCHAR(256) NOT NULL,
  "min_students" INT NOT NULL,
  "max_students" INT NOT NULL,
  "genre" VARCHAR(256),
  "price_id" uuid NOT NULL,
  "instructor_id" uuid NOT NULL,
  "instructor_pay" INT not null, 
  CONSTRAINT fk_instructor_id FOREIGN KEY (instructor_id) REFERENCES "instructor"(id) ON DELETE CASCADE,
  CONSTRAINT fk_price_id FOREIGN KEY (price_id) REFERENCES "price"(id) ON DELETE CASCADE,
  "time_slot_id" uuid NOT NULL,
  CONSTRAINT fk_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES "time_slot"(id) ON DELETE CASCADE
);

CREATE TABLE "individual_lesson"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "level" VARCHAR(256) NOT NULL,
  "price_id" uuid NOT NULL,
  "time_slot_id" uuid NOT NULL,
  "instructor_id" uuid NOT NULL,
  "instrument_type_name" VARCHAR(256) NOT NULL,
  "instructor_pay" INT not null, 
  CONSTRAINT fk_instrument_type_name FOREIGN KEY (instrument_type_name) REFERENCES "instrument_type"("name") ON DELETE CASCADE,
  CONSTRAINT fk_price_id FOREIGN KEY (price_id) REFERENCES "price"(id) ON DELETE CASCADE,
  CONSTRAINT fk_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES "time_slot"(id) ON DELETE CASCADE,
  CONSTRAINT fk_instructor_id FOREIGN KEY (instructor_id) REFERENCES "instructor"(id) ON DELETE CASCADE
);

CREATE TABLE "individual_lesson_student"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "individual_lesson_id" uuid UNIQUE NOT NULL,
  "student_id" uuid NOT NULL,
  "price" INT NOT NULL,
  "state" VARCHAR(256) NOT NULL DEFAULT 'accepted',
  CONSTRAINT fk_individual_lesson_id FOREIGN KEY (individual_lesson_id) REFERENCES "individual_lesson"(id) ON DELETE CASCADE,
  CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES "student"(id) ON DELETE CASCADE
);

CREATE TABLE "group_lesson_student"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "group_lesson_id" uuid NOT NULL,
  "student_id" uuid NOT NULL,
  "price" INT NOT NULL,
  "state" VARCHAR(256) NOT NULL DEFAULT 'accepted',
  CONSTRAINT fk_group_lesson_id FOREIGN KEY (group_lesson_id) REFERENCES "group_lesson"(id) ON DELETE CASCADE,
  CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES "student"(id) ON DELETE CASCADE
);

CREATE TABLE "ensemble_lesson_student"(
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ensemble_lesson_id" uuid NOT NULL,
  "student_id" uuid NOT NULL,
  "price" INT NOT NULL,
  "state" VARCHAR(256) NOT NULL DEFAULT 'accepted',
  CONSTRAINT fk_ensemble_lesson_id FOREIGN KEY (ensemble_lesson_id) REFERENCES "ensemble_lesson"(id) ON DELETE CASCADE,
  CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES "student"(id) ON DELETE CASCADE
);

CREATE TABLE "instructor_instrument"(
  "instructor_id" uuid NOT NULL,
  "instrument_type_name" VARCHAR(256) NOT NULL,
  PRIMARY KEY (instructor_id, instrument_type_name),
  CONSTRAINT fk_instructor_id FOREIGN KEY (instructor_id) REFERENCES "instructor"(id) ON DELETE CASCADE,
  CONSTRAINT fk_instrument_type_name FOREIGN KEY (instrument_type_name) REFERENCES "instrument_type"("name") ON DELETE CASCADE
);

CREATE TABLE "instructor_time_slots"(
  "instructor_id" uuid NOT NULL,
  "time_slot_id" uuid NOT NULL,
  PRIMARY KEY (instructor_id, time_slot_id),
  CONSTRAINT fk_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES "time_slot"(id) ON DELETE CASCADE,
  CONSTRAINT fk_instructor_id FOREIGN KEY (instructor_id) REFERENCES "instructor"(id) ON DELETE CASCADE
);

CREATE TABLE "ensemble_lesson_instrument"(
  "ensemble_lesson_id" uuid NOT NULL,
  "instrument_type_name" VARCHAR(256) NOT NULL,
  PRIMARY KEY (ensemble_lesson_id, instrument_type_name),
  CONSTRAINT fk_ensemble_lesson_id FOREIGN KEY (ensemble_lesson_id) REFERENCES "ensemble_lesson"(id) ON DELETE CASCADE,
  CONSTRAINT fk_instrument_type_name FOREIGN KEY (instrument_type_name) REFERENCES "instrument_type"("name") ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION check_instrument_rent_limit()
RETURNS TRIGGER AS $$
BEGIN
  IF (SELECT COUNT(*) FROM instrument WHERE student_id = NEW.student_id) >= 2 THEN
    RAISE EXCEPTION 'Student cannot have more than 2 instruments';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_max_instruments
    BEFORE UPDATE ON instrument
    FOR EACH ROW
    EXECUTE FUNCTION check_instrument_rent_limit();
   

