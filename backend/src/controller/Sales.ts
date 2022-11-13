import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";

const prisma = new PrismaClient();

export class SalesDataController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;
    const { getCount } = req.query;
    let count;

    if (getCount) {
      count = await prisma.kunde.count({
        where: {
          ...filter,
        },
      });
    }
    const allSalesData = await prisma.umsatzdaten.findMany({
      take: rows,
      skip: page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json({ data: allSalesData, count });
  }
  async get(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    try {
      const { id } = req.params;

      const salesData = await prisma.umsatzdaten.findUnique({
        where: {},
      });

      return res.json(salesData);
    } catch (err) {
      await prisma.$disconnect();
      return next(err);
    }
  }
  async delete(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    try {
      const { id } = req.params;
      const salesData = await prisma.umsatzdaten.delete({
        where: {},
      });

      return res.json(salesData);
    } catch (err) {
      await prisma.$disconnect();
      return next(err);
    }
  }
  async update(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    try {
      const { id } = req.params;
      console.log(req.body);

      const { data }: { data: Prisma.AuftragUpdateInput } = req.body;

      const salesData = await prisma.umsatzdaten.updateMany({
        data,
        where: {},
      });

      return res.json(salesData);
    } catch (err) {
      await prisma.$disconnect();
      return next(err);
    }
  }
}
