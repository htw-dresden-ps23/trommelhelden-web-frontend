import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const getEmployees = async (req: Request, res: Response) => {
  try {
    console.log("Request received");

    const data = await prisma.mitarbeiter.findMany();
    return res.send(JSON.stringify(data));
  } catch (e) {}
};
