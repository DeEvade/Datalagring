const fs = require('fs');
const faker = require('faker');

// Sanitization function to remove single and double quotes from strings
const sanitizeString = (str) => str.replace(/['"]+/g, '');

const generateDummyData = () => {
  const dummyData = [];
  const personIds = [];
  const studentIds = [];
  const instructorIds = [];
  const priceIds = [];
  const timeSlotIds = [];
  const instrumentTypeNames = [];

  for (let i = 0; i < 100; i++) {
    // Generate data for 'person'
    const personId = faker.datatype.uuid();
    personIds.push(personId);
    dummyData.push(`INSERT INTO person (id, first_name, last_name, social_security, address, email, phone) VALUES ('${personId}', '${sanitizeString(faker.name.firstName())}', '${sanitizeString(faker.name.lastName())}', '${faker.datatype.number({ min: 100000000, max: 999999999 }).toString()}', '${sanitizeString(faker.address.streetAddress())}', '${sanitizeString(faker.internet.email())}', '${sanitizeString(faker.phone.phoneNumber())}');`);

    // Generate data for 'student' inheriting 'person'
    const studentId = personId; // Inherited, so it's the same ID
    studentIds.push(studentId);
    dummyData.push(`INSERT INTO student (id, max_instrument_rent_amount, contact_person_id) VALUES ('${studentId}', ${faker.datatype.number({ min: 100, max: 500 })}, '${personId}');`);

    // Generate data for 'instructor' inheriting 'person'
    const instructorId = faker.datatype.uuid();
    instructorIds.push(instructorId);
    dummyData.push(`INSERT INTO person (id, first_name, last_name, social_security, address, email, phone) VALUES ('${instructorId}', '${sanitizeString(faker.name.firstName())}', '${sanitizeString(faker.name.lastName())}', '${faker.datatype.number({ min: 100000000, max: 999999999 }).toString()}', '${sanitizeString(faker.address.streetAddress())}', '${sanitizeString(faker.internet.email())}', '${sanitizeString(faker.phone.phoneNumber())}');`);
    dummyData.push(`INSERT INTO instructor (id, contact_person_id) VALUES ('${instructorId}', '${instructorId}');`);

    // Generate data for 'price'
    const priceId = faker.datatype.uuid();
    priceIds.push(priceId);
    dummyData.push(`INSERT INTO price (id, class_type, level, sibling_discount, cost) VALUES ('${priceId}', '${sanitizeString(faker.commerce.product())}', '${sanitizeString(faker.name.jobType())}', ${faker.datatype.number({ min: 0, max: 100 })}, ${faker.datatype.number({ min: 100, max: 1000 })});`);

    // Generate data for 'time_slot'
    const timeSlotId = faker.datatype.uuid();
    timeSlotIds.push(timeSlotId);
    dummyData.push(`INSERT INTO time_slot (id, start_time, end_time) VALUES ('${timeSlotId}', '${faker.date.recent().toISOString()}', '${faker.date.soon().toISOString()}');`);

    // Generate data for 'instrument_type'
    const instrumentTypeName = sanitizeString(faker.commerce.productMaterial());
    instrumentTypeNames.push(instrumentTypeName);
    dummyData.push(`INSERT INTO instrument_type (name) VALUES ('${instrumentTypeName}');`);

    // ... Additional entities and their relationships ...
  }

  return dummyData.join('\n');
};

const dummyDataSql = generateDummyData();
const filePath = './dummy_data.sql';
fs.writeFileSync(filePath, dummyDataSql, 'utf-8');
console.log(`Dummy SQL data file created at: ${filePath}`);
