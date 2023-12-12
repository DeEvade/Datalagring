const express = require("express");
const { listInstruments } = require("./templates");
const { unrent } = require("./Model");

const dotenv = require("dotenv");
const Integration = require("./integration");

const pool = require("./pool").getSQLPool();

const integration = new Integration(pool);

const app = express();
dotenv.config();
const port = 8080;

app.get("/", async (req, res) => {
  const response = await integration.test();
  res.send("hello world" + JSON.stringify(response));
});

app.get("/listInstruments", async (req, res) => {
  //const queryString = constructListInstrumentsQuery();
  const response = await integration.listInstrument();
  const website = listInstruments(response);

  res.send(website);
});

app.get("/unrent/:instrumentId", async (req, res) => {
  const instrumentId = req.params.instrumentId;
  try {
    const result = await unrent(instrumentId, integration);
    res.send(result);
  } catch (error) {
    res.send(error);
  }
});

app.get("/rent/:userId", async (req, res) => {
  //const timeSlotId = req.query.timeSlotId;
  const userId = req.params.userId;
  const instrumentId = req.query.instrumentId;
  console.log("Received request:", { userId, instrumentId });
  try {
    const result = await integration.createContract(userId, instrumentId);
    res.send(result);
  } catch (error) {
    res.send(error.message);
  }
});

app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}`);
});
