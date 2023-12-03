const express = require("express");
const { constructListInstrumentsQuery } =  require("./task_4");
const dotenv = require("dotenv");

const db = require("./pool").getSQLPool();

const app = express();
dotenv.config();
const port = 8080;

app.get("/", async (req, res) => {
  const response = await db.query("select * from student");
  res.send("hello world" + JSON.stringify(response["rows"]));
});

app.get("/listInstruments", async (req, res) => {
  const response = await db.query(constructListInstrumentsQuery());

  const website = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hello</title>
</head>
<body>
<div>
${response["rows"].map((instrument) => {
  return `
  <div>
    <h1>${instrument.instrument_type_name + " " + instrument.model}</h1>
    <p>${instrument.price}</p>
  </div>
  <br />`;

}).join("")}
</div>
</body>
</html>
  
`;

  res.send(website);
});

app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}`);
});
