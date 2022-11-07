import { NextFunction, Request, Response } from "express";
import { Prisma, PrismaClient } from "@prisma/client";
import { Runtype } from "runtypes";
import { send } from "process";

const prisma = new PrismaClient();

export class ProductsController {
  async list(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { sort, filter, page, rows } = req.body
      console.log(req.body)
      const allProducts = await prisma.produkt.findMany(
        {
          take: rows , 
          skip: rows * page,
          where:{
            ...filter
          },
          orderBy: [
            ...sort
          ]
          }
      );
      if(allProducts.length > 0) {
        return res.status(200).json(allProducts);
      }
      return res.status(500).send('Keine Produkte gefunden')
    } catch (err) {
       await prisma.$disconnect()
      return next(err);
    }
  }
  async delete(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      const product = await prisma.produkt.delete({
        where: {

        },
      });

      return res.json(product);
    } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
  async update(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      console.log(req.body);

      const { data }: { data: Prisma.ProduktUpdateInput } = req.body;

      const product = await prisma.produkt.updateMany({
        data,
        where: {
        },
      });

      return res.json(product);
    } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
}