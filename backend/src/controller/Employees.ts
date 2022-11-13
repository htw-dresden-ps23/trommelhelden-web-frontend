import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";
import { uuid } from "uuidv4";

const prisma = new PrismaClient();

export class EmployeesController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;

    const allEmployees = await prisma.mitarbeiter.findMany({
      take: rows,
      skip: rows * page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json(allEmployees);
  }
  async get(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;

    const employee = await prisma.mitarbeiter.findUnique({
      where: {
        MitID: String(id),
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
          MitID: String(id),
        },
      });
    }
    if (ids) {
      await prisma.mitarbeiter.deleteMany({
        where: {
          MitID: {
            in: ids.map((x: string) => String(x)),
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
        MitID: String(id),
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

    console.log(uuid().slice(0, 3));

    const { MitID } = await prisma.mitarbeiter.create({
      data: { ...data, MitID: uuid().slice(0, 3) },
    });

    return res.status(200).json(MitID);
  }
}
