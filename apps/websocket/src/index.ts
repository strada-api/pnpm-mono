import cors from "cors";
import express from "express";
import { addition, multiply } from "utils";

const app = express();

// Core Middlewares
app.use(cors());
app.use(express.json());

// Routes
app.get("/_health", async (_, res) => {
  console.log("heare");
  // Healthcheck
  try {
    console.log(addition(4, 5));
    console.log(multiply(4, 2));
    res.sendStatus(200);
  } catch (e) {
    res.status(500).send(e);
  }
});

const SERVER_PORT = 3105;
app.listen(SERVER_PORT, () =>
  console.log(`Server ready at: http://localhost:${SERVER_PORT}`)
);
