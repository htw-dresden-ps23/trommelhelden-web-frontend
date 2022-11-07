import express, { Request, Response } from "express";
import { listTables } from "./controller/index";
import { OrdersController } from "./controller/auftrag";
import { CustomersController } from "./controller/kunde";
import { EmployeesController } from "./controller/mitarbeiter";
import { SalesDataController } from "./controller/umsatzdaten";
import { ProductsController } from "./controller/produkt";
import cors from "cors";
import { prismaErrorMiddleware } from "./middleware";

const app = express();
app.use(cors());
app.use(express.json());
const port = 4000;

const ordersController = new OrdersController();
app.post("/orders", ordersController.list);
app.put("/order/:id?", ordersController.put);
app.patch("/order/:id", ordersController.update);
app.delete("/order/:id", ordersController.delete);

const customersController = new CustomersController();
app.post("/customers", customersController.list);
// app.put("/customers", customersController.put);
app.patch("/customer/:id", customersController.update);
app.delete("/customer/:id", customersController.delete);

const employeesController = new EmployeesController();
app.post("/employees", employeesController.list);
// app.get("/employees", employeesController.get);
app.patch("/employee/:id", employeesController.update);
app.delete("/employee/:id", employeesController.delete);

const salesDataController = new SalesDataController();
app.post("/sales", salesDataController.list);
app.patch("/salesData/:id", salesDataController.update);
app.delete("/salesData/:id", salesDataController.delete);

const productsController = new ProductsController();
app.post("/product/:id?", productsController.list);
app.patch("/product/:id", productsController.update);
app.delete("/product/:id", productsController.delete);


app.use(prismaErrorMiddleware);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
