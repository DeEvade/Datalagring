const express = require("express");
const dotenv = require("dotenv");

const db = require("./pool").getSQLPool();



const app = express();
dotenv.config();
const port = 8080;

app.get("/", async(req, res) => {
  const response = await db.query("select * from student");
  console.log(response);
  res.send("hello world" + JSON.stringify(response["rows"]));
});

app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}`);
});
