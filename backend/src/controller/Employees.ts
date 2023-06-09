import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";
import { uuid } from "uuidv4";

const prisma = new PrismaClient({
  log: ["query", "info", "warn", "error"],
});

export class EmployeesController {
  async list(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;
    const { getCount } = req.query;
    let count;

    if (getCount) {
      count = await prisma.mitarbeiter.count({
        where: {
          ...filter,
        },
      });
    }
    const allEmployees = await prisma.mitarbeiter.findMany({
      take: rows,
      skip: page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json({ data: allEmployees, count });
  }
  async get(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    const { id } = req.params;

    const employee = await prisma.mitarbeiter.findUnique({
      where: {
        MitID: Number(id),
      },
    });

    return res.json(employee);
  }
  async delete(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;
    const { ids } = req.body;

    if (id) {
      await prisma.mitarbeiter.delete({
        where: {
          MitID: Number(id),
        },
      });
    }
    if (ids) {
      await prisma.mitarbeiter.deleteMany({
        where: {
          MitID: {
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
    const { data }: { data: Prisma.MitarbeiterUpdateInput } = req.body;

    const employee = await prisma.mitarbeiter.updateMany({
      data,
      where: {
        MitID: Number(id),
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
    let nlnr = data.NLNr;
    delete data.NLNr;

    const { MitID } = await prisma.mitarbeiter.create({
      data: {
        Niederlassung: {
          connect: {
            NLNr: Number(nlnr),
          },
        },
        ...data,
        MitID: uuid(),
      },
    });

    return res.status(200).json(MitID);
  }
}
