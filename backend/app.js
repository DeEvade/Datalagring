const express = require("express");
const { constructListInstrumentsQuery } = require("./task_4");
const { listInstruments } = require("./templates");

const dotenv = require("dotenv");
const Integration = require("./integration");

const pool = require("./pool").getSQLPool();

const integration = new Integration(pool);

const app = express();
dotenv.config();
const port = 8080;

app.get("/", async (req, res) => {
  const response = await integration.query("select * from student");
  res.send("hello world" + JSON.stringify(response));
});

app.get("/listInstruments", async (req, res) => {
  const queryString = constructListInstrumentsQuery();
  const response = await integration.query(queryString);
  const website = listInstruments(response);

  res.send(website);
});

app.get("/rent/:userId", async (req, res) => {
  /*
  const queryString = constructListInstrumentsQuery();
  const response = await integration.query(queryString);
  const website = listInstruments(response);*/

  res.send(req.params.userId);
});

app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}`);
});
