import express, { Request, Response } from "express";
import { OrdersController } from "./controller/Orders";
import { CustomersController } from "./controller/Customers";
import { EmployeesController } from "./controller/Employees";
import { ProductsController } from "./controller/Spareparts";
import { BranchesController } from "./controller/Branches";
import cors from "cors";
import { prismaErrorMiddleware } from "./middleware";
require('express-async-errors');

import morgan from "morgan"



const app = express();
app.use(cors());
app.use(express.json());
app.use(morgan('dev'))

const port = 4000;


const ordersController = new OrdersController();
app.get("/orders/:id", ordersController.get);
app.post("/orders", ordersController.list);
app.patch("/order/:id", ordersController.update);
app.delete("/order/:id", ordersController.delete);

const customersController = new CustomersController();
app.get("/customers/:id", customersController.get);
app.post("/customers", customersController.list);
app.patch("/customer/:id", customersController.update);
app.delete("/customer/:id", customersController.delete);

const employeesController = new EmployeesController();
app.get("/employees/:id", employeesController.get);
app.post("/employees", employeesController.list);
app.patch("/employee/:id", employeesController.update);
app.delete("/employee/:id", employeesController.delete);


const productsController = new ProductsController();
app.post("/products", productsController.list);
app.patch("/product/:id", productsController.update);
app.delete("/product/:id", productsController.delete);

const branchesController = new BranchesController()
app.get("/branches/:id", branchesController.get);
app.post("/branches", branchesController.create);
app.post("/branches", branchesController.list);
app.patch("/branches/:id", branchesController.update);
app.delete("/branches/:id", branchesController.delete);

app.use(prismaErrorMiddleware);



app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
