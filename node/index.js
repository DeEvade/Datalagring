const fs = require('fs');
const faker = require('faker');

const generateDummyData = () => {
  const uuidv4 = faker.datatype.uuid;
  const randomNumber = faker.datatype.number;
  const dummyData = [];

  // Generate data for 'person'
  const personId = uuidv4();
  dummyData.push(`INSERT INTO person (id, first_name, last_name, social_security, address, email, phone) VALUES ('${personId}', '${faker.name.firstName()}', '${faker.name.lastName()}', '${randomNumber({ min: 100000000, max: 999999999 })}', '${faker.address.streetAddress()}', '${faker.internet.email()}', '${faker.phone.phoneNumber()}');`);

  // Generate data for 'instructor'
  const instructorId = uuidv4();
  dummyData.push(`INSERT INTO instructor (id, contact_person_id) VALUES ('${instructorId}', '${personId}');`);

  // Generate data for 'student'
  const studentId = uuidv4();
  dummyData.push(`INSERT INTO student (id, max_instrument_rent_amount, contact_person_id) VALUES ('${studentId}', ${randomNumber({ min: 100, max: 500 })}, '${personId}');`);

  // Generate data for 'instrument_type'
  const instrumentTypeId = uuidv4();
  dummyData.push(`INSERT INTO instrument_type (id, name) VALUES ('${instrumentTypeId}', '${faker.commerce.productName()}');`);

  // Generate data for 'price'
  const priceId = uuidv4();
  dummyData.push(`INSERT INTO price (id, class_type, level, sibling_discount, cost) VALUES ('${priceId}', 'Basic', 'Beginner', ${randomNumber({ min: 0, max: 100 })}, ${randomNumber({ min: 100, max: 1000 })});`);

  // Generate data for 'time_slot'
  const timeSlotId = uuidv4();
  dummyData.push(`INSERT INTO time_slot (id, start_time, end_time) VALUES ('${timeSlotId}', '${faker.date.recent().toISOString()}', '${faker.date.soon().toISOString()}');`);

  // Generate data for 'ensemble_lesson'
  const ensembleLessonId = uuidv4();
  dummyData.push(`INSERT INTO ensemble_lesson (id, level, min_students, max_students, genre, price_id, instructor_id, time_slot_id) VALUES ('${ensembleLessonId}', 'Intermediate', ${randomNumber({ min: 1, max: 10 })}, ${randomNumber({ min: 10, max: 30 })}, '${faker.music.genre()}', '${priceId}', '${instructorId}', '${timeSlotId}');`);

  // Assuming 'ensemble_lesson_student' is a joining table between 'ensemble_lesson' and 'student'
  dummyData.push(`INSERT INTO ensemble_lesson_student (id, ensemble_lesson_id, student_id, price, state) VALUES ('${uuidv4()}', '${ensembleLessonId}', '${studentId}', ${randomNumber({ min: 10, max: 100 })}, 'active');`);

  // ... Continue for other entities ...

  return dummyData.join('\n');
};

// Write the data to a SQL file
fs.writeFileSync('dummy_data.sql', generateDummyData(), 'utf-8');
console.log('Dummy SQL data file created!');
