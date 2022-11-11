import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";

const prisma = new PrismaClient();

export class CustomersController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;
    const allCustomers = await prisma.kunde.findMany({
      take: rows,
      skip: rows * page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json(allCustomers);
  }
  async get(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;

    const customer = await prisma.kunde.findUnique({
      where: {
        KunNr: Number(id),
      },
    });

    return res.json(customer);
  }
  async delete(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;
    const { ids } = req.body;

    if (id) {
      await prisma.kunde.delete({
        where: {
          KunNr: Number(id),
        },
      });
    }
    if (ids) {
      await prisma.kunde.deleteMany({
        where: {
          KunNr: {
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
    console.log("Kik");

    const { id } = req.params;
    const { data }: { data: Prisma.KundeUpdateInput } = req.body;

    await prisma.kunde.update({
      data,
      where: {
        KunNr: Number(id),
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
    const { KunNr } = await prisma.kunde.create({
      data,
    });

    return res.status(200).json(KunNr);
  }
}
