import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";

const prisma = new PrismaClient();

export class SparepartsController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;

    const allSpareparts = await prisma.ersatzteil.findMany({
      take: rows,
      skip: rows * page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json(allSpareparts);
  }
  async get(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;

    const branch = await prisma.ersatzteil.findUnique({
      where: {
        EtID: String(id),
      },
    });

    return res.json(branch);
  }
  async delete(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;
    const { ids } = req.body;

    if (id) {
      await prisma.ersatzteil.delete({
        where: {
          EtID: String(id),
        },
      });
    }
    if (ids) {
      await prisma.ersatzteil.deleteMany({
        where: {
          EtID: {
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
    const { data }: { data: Prisma.ErsatzteilUpdateInput } = req.body;

    await prisma.ersatzteil.updateMany({
      data,
      where: {
        EtID: String(id),
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
    const { EtID } = await prisma.ersatzteil.create({
      data,
    });

    return res.status(200).json(EtID);
  }
}
