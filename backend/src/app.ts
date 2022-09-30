import express, { Request, Response } from "express";
import { getEmployees } from "./controller";
import cors from "cors";

const app = express();
app.use(cors());
const port = 5000;

app.get("/employees", getEmployees);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
