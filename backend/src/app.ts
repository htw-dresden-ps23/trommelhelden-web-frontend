import express, { Request, Response } from "express";
import {listTables} from "./controller/index";
import {getAssignments, updateAssignments, deleteAssignments, AssignmentController } from "./controller/auftrag";
import {getCustomers, updateCustomers, deleteCustomers } from "./controller/kunde";
import {getEmployees, updateEmployees, deleteEmployees } from "./controller/mitarbeiter";
import {getSalesData, updateSalesData, deleteSalesData } from "./controller/umsatzdaten";
import {getProducts, updateProducts, deleteProducts } from "./controller/produkt";
import cors from "cors";
import { prismaErrorMiddleware } from "./middleware";

const app = express();
app.use(cors());
app.use(express.json());
const port = 5000;

app.get("/tables", listTables);
app.get("/tables/assignments", getAssignments);
app.get("/tables/customers", getCustomers);
app.get("/tables/employees", getEmployees);
app.get("/tables/salesdata", getSalesData);
app.get("/tables/products", getProducts);

app.patch("/tables", listTables);
app.patch("/tables/assignments", updateAssignments);
app.patch("/tables/customers", updateCustomers);
app.patch("/tables/employees", updateEmployees);
app.patch("/tables/salesdata", updateSalesData);
app.patch("/tables/products", updateProducts);

app.delete("/tables", listTables);
app.delete("/tables/assignments", deleteAssignments);
app.delete("/tables/customers", deleteCustomers);
app.delete("/tables/employees", deleteEmployees);
app.delete("/tables/salesdata", deleteSalesData);
app.delete("/tables/products", deleteProducts);

const assignmentController = new AssignmentController();
app.get("/tables/assignments/:id?", assignmentController.get);
app.patch("/tables/assignments/:id", assignmentController.update);
app.delete("/tables/assignments/:id", assignmentController.delete);

const orderController = new OrderController();
app.get("/tables/orders/:id?", orderController.get);
app.patch("/tables/orders/:id", orderController.update);
app.delete("/tables/orders/:id", orderController.delete);



app.use(prismaErrorMiddleware);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
