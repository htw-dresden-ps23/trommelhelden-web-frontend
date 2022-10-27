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
app.get("/orders", ordersController.get);
app.put("/order/:id?", ordersController.get);
app.patch("/order/:id", ordersController.update);
app.delete("/order/:id", ordersController.delete);

const customersController = new CustomersController();
app.get("/customer/:id?", customersController.get);
app.get("/customers", customersController.get);
app.patch("/customer/:id", customersController.update);
app.delete("/customer/:id", customersController.delete);

const employeesController = new EmployeesController();
app.get("/employee/:id?", employeesController.get);
app.get("/employees", employeesController.get);
app.patch("/employee/:id", employeesController.update);
app.delete("/employee/:id", employeesController.delete);

const salesDataController = new SalesDataController();
app.get("/salesData/:id?", salesDataController.get);
app.patch("/salesData/:id", salesDataController.update);
app.delete("/salesData/:id", salesDataController.delete);

const productsController = new ProductsController();
app.get("/product/:id?", productsController.get);
app.patch("/product/:id", productsController.update);
app.delete("/product/:id", productsController.delete);


app.use(prismaErrorMiddleware);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
