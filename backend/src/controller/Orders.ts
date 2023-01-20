import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient({
  log: ["query", "info", "warn", "error"],
});

export class OrdersController {
  async list(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    const { sort, filter, page, rows } = req.body;
    const { getCount, status, getSum, invoice } = req.query;

    if (!Boolean(invoice)) {
      console.log("no invoice");

      filter.Rechnung = {
        every: {
          RechBetrag: {
            gt: 0,
          },
        },
      };
    }

    let query: any = {
      take: rows,
      skip: page,
      where: {
        ...filter,
      },
      include: {
        Kunde: true,
        Rechnung: true,
        Mitarbeiter: {
          include: {
            Niederlassung: true,
          },
        },
      },
      orderBy: [...sort],
    };

    if (!rows) {
      delete query.take;
    }

    console.log(query);

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
    let count, sum: any, invoiceFilter;

    if (getCount) {
      count = await prisma.auftrag.count({
        where: {
          ...query.where,
        },
      });
    }

    const allOrders = await prisma.auftrag.findMany(query);

    if (getSum) {
      console.log("getSum");

      sum =
        await prisma.$queryRaw`SELECT sum(r.RechBetrag) as Umsatz FROM Auftrag a INNER JOIN Rechnung r ON r.AufNr = a.Aufnr `;
      return res.status(200).json({ data: allOrders, count, sum: sum[0]?.Umsatz });
    }

    return res.status(200).json({ data: allOrders, count });
  }
  async get(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    const { id } = req.params;

    const order = await prisma.auftrag.findUnique({
      where: {
        Aufnr: Number(id),
      },
      include: {
        Kunde: true,
        Mitarbeiter: true,
        Montage: {
          include: {
            Ersatzteil: true,
          },
        },
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

    const order = await prisma.auftrag.update({
      include: {
        Montage: true,
      },
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
