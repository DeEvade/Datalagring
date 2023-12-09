const listInstruments = (instruments) => {
  return `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hello</title>
</head>
<body>
<div>
${instruments
  .map((instrument) => {
    return `
  <div>
    <h1>${instrument.instrument_type_name + " " + instrument.model}</h1>
    <p>${instrument.price}</p>
    <p>${instrument.id}</p>
  </div>
  <br />`;
  })
  .join("")}
</div>
</body>
</html>
`;
};


exports.listInstruments = listInstruments;