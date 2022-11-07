import { NextFunction, Request, Response } from "express";
import { Prisma, PrismaClient } from "@prisma/client";
import { Runtype } from "runtypes";
import { send } from "process";

const prisma = new PrismaClient();

export class OrdersController {
  async list(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const allOrders = await prisma.auftrag.findMany();
      if(allOrders.length > 0) {
        return res.status(200).json(allOrders);
      }
      return res.status(500).send('Keine Aufträge gefunden')
    } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
  async put(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { data }: { data: Prisma.AuftragCreateInput } = req.body;
      const allOrders = await prisma.auftrag.create({
        data,});
      } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
  async delete(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      const order = await prisma.auftrag.delete({
        where: { 
          
        },
      });

      return res.json(order);
    } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
  async update(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      console.log(req.body);

      const { data }: { data: Prisma.AuftragUpdateInput } = req.body;

      const order = await prisma.auftrag.updateMany({
        data,
        where: {  },
      });

      return res.json(order);
    } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
}
