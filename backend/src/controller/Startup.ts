import { PrismaClient, prisma } from "@prisma/client";
import { resetErrorsCount } from "ajv/dist/compile/errors";
import { NextFunction, Request, Response } from "express";
import { createData } from "../services/db-startup";

const prismaClient = new PrismaClient();

export const startUp = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<Response | void> => {
  const { customers, employees, orders, branches, spareparts } = req.body;

  if (
    customers === 0 &&
    employees === 0 &&
    orders === 0 &&
    branches === 0 &&
    spareparts === 0
  ) {
    return res.status(400).json({
      message: "No data to insert",
    });
  }
  console.log(req.body);

  await createData(customers, employees, orders, branches, spareparts);
  console.log("yooo");

  return res.sendStatus(200);
};

export const isStartUp = async (req: Request, res: Response, next: NextFunction) => {
  const orders = await prismaClient.auftrag.count();
  const employees = await prismaClient.mitarbeiter.count();
  const customers = await prismaClient.kunde.count();

  return res.json({
    isStartUp: orders === 0 && employees === 0 && customers === 0,
  });
};
