import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();

export class InvoicesController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;
    const { getCount } = req.query;
    let count;

    if (getCount) {
      count = await prisma.rechnung.count({
        where: {
          ...filter,
        },
      });
    }

    const allInvoices = await prisma.rechnung.findMany({
      take: rows,
      skip: page,
      where: {
        ...filter,
      },
      orderBy: [...sort],
    });
    return res.status(200).json({ data: allInvoices, count });
  }
  async get(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { KunNr, AufNr } = req.query;

    const invoice = await prisma.rechnung.findUnique({
      where: {
        KunNr_AufNr: {
          AufNr: Number(AufNr),
          KunNr: Number(KunNr),
        },
      },
    });

    return res.status(200).json(invoice);
  }
  //   async delete(
  //     req: Request,
  //     res: Response,
  //     next: NextFunction
  //   ): Promise<Response | void> {
  //     const { KunNr, AufNr } = req.query;

  //     if (id) {
  //       await prisma.rechnung.delete({
  //         where: {
  //           NLNr: Number(id),
  //         },
  //       });
  //     }

  //     return res.sendStatus(200);
  //   }

  async update(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { KunNr, AufNr } = req.query;
    const { data }: { data: Prisma.RechnungUpdateInput } = req.body;

    await prisma.rechnung.update({
      data,
      where: {
        KunNr_AufNr: {
          AufNr: Number(AufNr),
          KunNr: Number(KunNr),
        },
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
    const { AufNr, KunNr } = await prisma.rechnung.create({
      data,
    });

    return res.status(200).json({ AufNr, KunNr });
  }
}
