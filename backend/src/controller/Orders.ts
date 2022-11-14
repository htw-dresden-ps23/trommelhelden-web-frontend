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
    const { getCount, status } = req.query;

    let query: any = {
      take: rows,
      skip: page,
      where: {
        ...filter,
      },
      include: {
        Kunde: true,
        Mitarbeiter: true,
      },
      orderBy: [...sort],
    };

    switch (status) {
      case "created":
        query.where = {
          ...filter,
          MitID: null,
          Dauer: null,
          Anfahrt: null,
        };
        break;
      case "planned":
        query.where = {
          ...filter,
          MitID: {
            not: null,
          },
          ErlDat: {
            not: null,
          },

          Dauer: null,
          Anfahrt: null,
        };
        break;
    }
    let count;

    if (getCount) {
      count = await prisma.auftrag.count({
        where: {
          ...filter,
          ...query.where,
        },
      });
    }

    const allOrders = await prisma.auftrag.findMany(query);
    return res.status(200).json({ data: allOrders, count });
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

    console.log(id);

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
    const { Kunde, ...y } = data;

    const { Aufnr } = await prisma.auftrag.create({
      data: {
        ...y,

        KunNr: Number(Kunde.KunNr),
      },
    });

    return res.status(200).json(Aufnr);
  }
}
