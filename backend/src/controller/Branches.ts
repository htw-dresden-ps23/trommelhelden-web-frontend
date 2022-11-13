import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";
const prisma = new PrismaClient();

export class BranchesController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;

    const alleBranches = await prisma.niederlassung.findMany({
      take: rows,
      skip: rows * page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json(alleBranches);
  }
  async get(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { id } = req.params;

    const branch = await prisma.niederlassung.findUnique({
      where: {
        NLNr: Number(id),
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
      await prisma.niederlassung.delete({
        where: {
          NLNr: Number(id),
        },
      });
    }
    if (ids) {
      await prisma.niederlassung.deleteMany({
        where: {
          NLNr: {
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
    const { data }: { data: Prisma.NiederlassungUpdateInput } = req.body;

    await prisma.niederlassung.update({
      data,
      where: {
        NLNr: Number(id),
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
    const { NLNr } = await prisma.niederlassung.create({
      data,
    });

    return res.status(200).json(NLNr);
  }
}
