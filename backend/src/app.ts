import express, { Request, Response } from "express";
import { getEmployees, listTables, OrderController } from "./controller";
import cors from "cors";
import { prismaErrorMiddleware } from "./middleware";

const app = express();
app.use(cors());
app.use(express.json());
const port = 5000;

app.get("/tables", listTables);
app.get("/tables/employees", getEmployees);

const orderController = new OrderController();
app.get("/tables/orders/:id?", orderController.get);
app.patch("/tables/orders/:id", orderController.update);
app.delete("/tables/orders/:id", orderController.delete);

app.use(prismaErrorMiddleware);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
