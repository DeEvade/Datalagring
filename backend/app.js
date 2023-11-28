import express from "express";
const app = express();
dotenv.config();
const port = process.env.PORT;

app.get("/", (req, res) => {
  res.send("hello world");
});

app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}`);
});
