import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";

const prisma = new PrismaClient();

export class BusinessDataController {
  async getInvoices(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { filter, calcType } = req.body;
    let data;
    console.log(calcType);

    switch (calcType) {
      case "database":
        {
          data = await prisma.rechnung.aggregate({
            _avg: {
              RechBetrag: true,
            },
            _sum: {
              RechBetrag: true,
            },
            _max: {
              RechBetrag: true,
            },
            _count: {
              RechBetrag: true,
            },
            _min: {
              RechBetrag: true,
            },
            where: {
              ...filter,
            },
          });
        }

        break;
      case "backend": {
        const data = await prisma.rechnung.findMany();

        // BERECHNEN IM BACKEND
      }
      case "frontend": {
        const data = await prisma.rechnung.findMany();
        return res.json(data);
      }
    }

    return res.json(data);
  }
  async getOrders(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { filter, calcType } = req.body;
    let data;
    console.log(req.params);

    switch (calcType) {
      case "database":
        {
          data = await prisma.auftrag.aggregate({
            _avg: {
              Anfahrt: true,
              Dauer: true,
            },
            _sum: {
              Anfahrt: true,
              Dauer: true,
            },
            _max: {
              Anfahrt: true,
              Dauer: true,
            },
            _count: {
              Anfahrt: true,
              Dauer: true,
            },
            _min: {
              Anfahrt: true,
              Dauer: true,
            },
            where: {
              ...filter,
            },
          });
        }

        break;
      case "backend": {
        const data = await prisma.rechnung.findMany();
        break;
        // BERECHNEN IM BACKEND
      }
      case "frontend": {
        const data = await prisma.rechnung.findMany();
        return res.json(data);
      }
    }

    return res.json(data);
  }
  async getAssembly(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { filter, calcType } = req.body;
    let data,
      min = {},
      max = {};
    console.log(calcType);

    switch (calcType) {
      case "database": {
        data = await prisma.montage.aggregate({
          _count: {
            Anzahl: true,
          },
          _avg: {
            Anzahl: true,
          },
          _sum: {
            Anzahl: true,
          },
          where: {
            ...filter,
          },
        });

        max =
          await prisma.$queryRaw`SELECT TOP 1 MAX(Anzahl) as Anzahl,E.EtId, E.EtBezeichnung,E.EtPreis,E.EtHersteller FROM MONTAGE M INNER JOIN ersatzteil e ON m.EtID = e.EtID GROUP BY E.EtId, E.EtBezeichnung,E.EtPreis,E.EtHersteller  `;

        min =
          await prisma.$queryRaw`SELECT TOP 1 MIN(Anzahl) as Anzahl,E.EtId, E.EtBezeichnung,E.EtPreis,E.EtHersteller FROM MONTAGE M INNER JOIN ersatzteil e ON m.EtID = e.EtID GROUP BY E.EtId, E.EtBezeichnung,E.EtPreis,E.EtHersteller `;
        console.log(min);
        console.log(max);

        break;
      }

      case "backend": {
        const data = await prisma.montage.findMany();
        // BERECHNEN IM BACKEND
      }
      case "frontend": {
        const data = await prisma.montage.findMany({
          include: {
            Ersatzteil: true,
          },
        });
        return res.json(data);
      }
    }

    return res.json({ data, max, min });
  }
  async getCustomers(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { filter, calcType } = req.body;
    let data;
    switch (calcType) {
      case "database":
        {
          data = await prisma.kunde.count({
            where: {
              ...filter,
            },
          });
        }

        break;
      case "backend": {
        const data = await prisma.rechnung.findMany();
        // BERECHNEN IM BACKEND
      }
      case "frontend": {
        const data = await prisma.rechnung.findMany();
        return res.json(data);
      }
    }

    return res.json(data);
  }
  async getEmployees(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { filter, calcType } = req.body;
    let data;
    switch (calcType) {
      case "database":
        {
          data = await prisma.mitarbeiter.count({
            where: {
              ...filter,
            },
          });
        }

        break;
      case "backend": {
        const data = await prisma.rechnung.findMany();
        // BERECHNEN IM BACKEND
      }
      case "frontend": {
        const data = await prisma.rechnung.findMany();
        return res.json(data);
      }
    }

    return res.json(data);
  }
}
