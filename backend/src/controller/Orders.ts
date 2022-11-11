import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";

const prisma = new PrismaClient();

export class OrdersController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;

    const allOrders = await prisma.auftrag.findMany({
      take: rows,
      skip: rows * page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json(allOrders);
  }
  async get(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;

    const order = await prisma.auftrag.findUnique({
      where: {
        Aufnr: Number(id),
      },
    });
    return res.json(order);
  }
  async delete(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;
    const { ids } = req.body;

    if (id) {
      await prisma.auftrag.delete({
        where: {
          Aufnr: Number(id),
        },
      });
    }
    if (ids) {
      await prisma.auftrag.deleteMany({
        where: {
          Aufnr: {
            in: ids.map((x: string) => Number(x)),
          },
        },
      });
    }
    return res.sendStatus(200);
  }
  async update(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;
    const { data }: { data: Prisma.AuftragUpdateInput } = req.body;

    const order = await prisma.auftrag.updateMany({
      data,
      where: {
        Aufnr: Number(id),
      },
    });

    return res.sendStatus(200);
  }
  async create(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { data } = req.body;
    if (!data) {
      return res.sendStatus(400);
    }
    const { Aufnr } = await prisma.auftrag.create({
      data,
    });

    return res.status(200).json(Aufnr);
  }
}
