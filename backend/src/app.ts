import cors from "cors";
import express, { Request, Response } from "express";
import { BranchesController } from "./controller/Branches";
import { CustomersController } from "./controller/Customers";
import { EmployeesController } from "./controller/Employees";
import { OrdersController } from "./controller/Orders";
import { SparepartsController } from "./controller/Spareparts";
import { prismaErrorMiddleware } from "./middleware";
require("express-async-errors");

import morgan from "morgan";
import { BusinessDataController } from "./controller/BusinessData";
import { InvoicesController } from "./controller/Invoices";
import { SettingsController } from "./controller/Settings";
import { isStartUp, startUp } from "./controller/Startup";

const app = express();
app.use(cors());
app.use(express.json());
app.use(morgan("dev"));

const port = 5001;

const ordersController = new OrdersController();
app.get("/orders/:id", ordersController.get);
app.post("/orders", ordersController.list);
app.put("/orders", ordersController.create);
app.patch("/orders/:id", ordersController.update);
app.delete("/order/:id", ordersController.delete);

const customersController = new CustomersController();
app.get("/customers/:id", customersController.get);
app.post("/customers", customersController.list);
app.put("/customers", customersController.create);
app.patch("/customers/:id", customersController.update);
app.delete("/customers/:id", customersController.delete);

const employeesController = new EmployeesController();
app.get("/employees/:id", employeesController.get);
app.put("/employees", employeesController.create);
app.post("/employees", employeesController.list);
app.patch("/employees/:id", employeesController.update);
app.delete("/employees/:id", employeesController.delete);

const sparepartsController = new SparepartsController();
app.get("/spareparts/:id", sparepartsController.get);
app.put("/spareparts", sparepartsController.create);
app.post("/spareparts", sparepartsController.list);
app.patch("/spareparts/:id", sparepartsController.update);
app.delete("/spareparts/:id", sparepartsController.delete);

const branchesController = new BranchesController();
app.get("/branches/:id", branchesController.get);
app.put("/branches", branchesController.create);
app.post("/branches", branchesController.list);
app.patch("/branches/:id", branchesController.update);
app.delete("/branches/:id", branchesController.delete);

const invoicesController = new InvoicesController();
app.get("/invoices", invoicesController.get);
app.put("/invoices", invoicesController.create);
app.post("/invoices", invoicesController.list);
app.patch("/invoices", invoicesController.update);

const settingsController = new SettingsController();
app.post("/settings", settingsController.list);
app.patch("/settings", settingsController.updateSettings);

app.get("/startup", isStartUp);
app.post("/startup", startUp);

const businessDataController = new BusinessDataController();

app.post("/business-data/sales/employees", businessDataController.getSalesEmployees);
app.post("/business-data/sales/branches", businessDataController.getSalesBranches);
app.post("/business-data/sales/customers", businessDataController.getSalesCustomers);
app.post("/business-data/trip", businessDataController.getTrip);
app.post("/business-data/spareparts", businessDataController.getSpareparts);
app.post("/business-data/sales", businessDataController.getSales);

app.use(prismaErrorMiddleware);

app.listen(port, () => {
  console.log(`Trommelhelden app listening on port ${port}`);
});
