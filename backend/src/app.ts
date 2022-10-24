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
const port = 5000;

const ordersController = new OrdersController();
app.put("/tables/Order/:id?", ordersController.put);
app.get("/tables/Order/:id?", ordersController.get);
app.patch("/tables/Order/:id", ordersController.update);
app.delete("/tables/Order/:id", ordersController.delete);

const customersController = new CustomersController();
app.get("/tables/customer/:id?", customersController.get);
app.get("/customers", customersController.get);
app.patch("/tables/customer/:id", customersController.update);
app.delete("/tables/customer/:id", customersController.delete);

const employeesController = new EmployeesController();
app.get("/tables/employee/:id?", employeesController.get);
app.get("/tables/employees", employeesController.get);
app.patch("/tables/employee/:id", employeesController.update);
app.delete("/tables/employee/:id", employeesController.delete);

const salesDataController = new SalesDataController();
app.get("/tables/salesData/:id?", salesDataController.get);
app.patch("/tables/salesData/:id", salesDataController.update);
app.delete("/tables/salesData/:id", salesDataController.delete);

const productsController = new ProductsController();
app.get("/tables/product/:id?", productsController.get);
app.patch("/tables/product/:id", productsController.update);
app.delete("/tables/product/:id", productsController.delete);


app.use(prismaErrorMiddleware);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
