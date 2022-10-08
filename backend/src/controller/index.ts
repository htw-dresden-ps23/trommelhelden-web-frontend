import { NextFunction, Request, Response } from "express";
import { Prisma, PrismaClient } from "@prisma/client";
import { Runtype } from "runtypes";
import { send } from "process";

const prisma = new PrismaClient();

export const getEmployees = async (req: Request, res: Response) => {
  try {
    console.log("Request received");

    const data = await prisma.mitarbeiter.findMany();
    return res.send(JSON.stringify(data));
  } catch (e) {
    return res.status(400).send(e);
  }
};

export const listTables = async (req: Request, res: Response, next: NextFunction) => {
  try {
    console.log("Request received");
    const data = await prisma.$queryRaw`SELECT * FROM INFORMATION_SCHEMA.TABLES `;
    return res.json(data);
  } catch (e) {
    return res.status(400).send(e);
  }
};

export class OrderController {
  async get(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      if (id) {
        const orders = await prisma.auftrag.findMany({
          where: {
            Aufnr: Number(id),
          },
        });
        return res.json(orders);
      } else {
        const orders = await prisma.auftrag.findMany();
        return res.json(orders);
      }
    } catch (err) {
      return next(err);
    }
  }
  async delete(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      const orders = await prisma.auftrag.delete({
        where: {
          Aufnr: Number(id),
        },
      });

      return res.json(orders);
    } catch (err) {
      return next(err);
    }
  }
  async update(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      console.log(req.body);

      const { data }: { data: Prisma.AuftragUpdateInput } = req.body;

      const orders = await prisma.auftrag.updateMany({
        data,
        where: {
          Aufnr: Number(id),
        },
      });

      return res.json(orders);
    } catch (err) {
      return next(err);
    }
  }
}
