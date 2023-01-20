import {
  Auftrag,
  Kunde,
  Mitarbeiter,
  Montage,
  Niederlassung,
  Prisma,
  PrismaClient,
  Rechnung,
} from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";
import {
  salesBranchesQuery,
  salesCustomersQuery,
  salesEmployeeQuery,
} from "../db/querries";
import { aggregateQuery } from "../util.helpers";

const prisma = new PrismaClient({
  log: ["query", "info", "warn", "error"],
});

export class BusinessDataController {
  async getSalesEmployees(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { orderBy, calcType, startDate, endDate, orderByDirection } = req.body;
    let data;

    switch (calcType) {
      case "database": {
        data = await prisma.$queryRawUnsafe(
          salesEmployeeQuery(startDate, endDate, orderBy, orderByDirection)
        );

        // data =  await prisma.$queryRaw`SELECT sum(a.RechBetrag) as Umsatz pro Mitarbeiter FROM Mitarbeiter m INNER JOIN Auftrag a ON m.Auftrag = a.Aufnr INNER JOIN Rechnung r ON r.Rechung = a.Aufnr WHERE
        // r.RechBetrag > 0 AND r.RechDat BETWEEN filter[0] AND filter[1] AND m.MitID = filter`;
        break;
      }

      case "backend": {
        const orders: any = [];
        let respo = [];
        let i = 1000;
        do {
          respo = await prisma.auftrag.findMany({
            include: {
              Rechnung: true,
              Mitarbeiter: true,
            },
            skip: i,
            take: 1000,
            where: {
              AufDat: {
                gte: startDate,
                lte: endDate,
              },
            },
          });
          orders.push(...respo);
          i += 1000;
        } while (respo.length > 0);

        data = Array.from(new Set(orders.map((order: Auftrag) => order.MitID)))
          .map((x) => {
            const filteredOrders = orders.filter((order: Auftrag) => order.MitID === x);
            return {
              MitID: x,
              MitName: filteredOrders[0]?.Mitarbeiter?.MitName,
              ...aggregateQuery(filteredOrders, orders, x),
            };
          })
          .sort((a: any, b: any) => {
            if (orderByDirection === "asc") {
              return a[orderBy] - b[orderBy];
            } else {
              return b[orderBy] - a[orderBy];
            }
          })
          .splice(0, 5);

        break;

        // BERECHNEN IM BACKEND
      }
    }

    return res.json(data);
  }
  async getSalesBranches(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { orderBy, calcType, startDate, endDate, orderByDirection } = req.body;
    let data;
    console.log(req.params);

    switch (calcType) {
      case "database":
        {
          data = await prisma.$queryRawUnsafe(
            salesBranchesQuery(startDate, endDate, orderBy, orderByDirection)
          );
        }

        break;
      case "backend": {
        const orders: any = [];
        let respo = [];
        let i = 1000;
        do {
          respo = await prisma.auftrag.findMany({
            include: {
              Rechnung: true,
              Mitarbeiter: {
                include: {
                  Niederlassung: true,
                },
              },
            },
            skip: i,
            take: 1000,
            where: {
              AufDat: {
                gte: startDate,
                lte: endDate,
              },
            },
          });

          orders.push(...respo);
          i += 1000;
        } while (respo.length > 0);

        data = Array.from(new Set(orders.map((order: any) => order.Mitarbeiter?.NLNr)))
          .map((x) => {
            const filteredOrders = orders.filter(
              (order: any) => order.Mitarbeiter?.NLNr === x
            );
            return {
              NLNr: x,
              Ort: filteredOrders[0].Mitarbeiter?.Niederlassung?.Ort,
              ...aggregateQuery(filteredOrders, orders, x),
            };
          })
          .sort((a: any, b: any) => {
            if (orderByDirection === "asc") {
              return a[orderBy] - b[orderBy];
            } else {
              return b[orderBy] - a[orderBy];
            }
          })
          .splice(0, 5);
      }
    }

    return res.json(data);
  }
  async getSalesCustomers(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { orderBy, calcType, startDate, endDate, orderByDirection } = req.body;

    let data,
      min = {},
      max = {};
    console.log(calcType);

    switch (calcType) {
      case "database": {
        data = await prisma.$queryRawUnsafe(
          salesCustomersQuery(startDate, endDate, orderBy, orderByDirection)
        );

        break;
      }

      case "backend":
        {
          const orders: any = [];
          let respo = [];
          let i = 1000;
          do {
            respo = await prisma.auftrag.findMany({
              include: {
                Rechnung: true,
                Kunde: true,
              },
              skip: i,
              take: 1000,
              where: {
                AufDat: {
                  gte: startDate,
                  lte: endDate,
                },
              },
            });
            orders.push(...respo);
            i += 1000;
          } while (respo.length > 0);

          data = Array.from(new Set(orders.map((order: any) => order.Kunde.KunOrt)))
            .map((x) => {
              const filteredOrders = orders.filter(
                (order: any) => order.Kunde.KunOrt === x
              );
              return {
                KunOrt: filteredOrders[0].Kunde.KunOrt,
                ...aggregateQuery(filteredOrders, orders, x),
              };
            })
            .sort((a: any, b: any) => {
              if (orderByDirection === "asc") {
                return a[orderBy] - b[orderBy];
              } else {
                return b[orderBy] - a[orderBy];
              }
            })
            .splice(0, 5);
        }
        break;
    }

    return res.json(data);
  }
  async getTrip(
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
  async getSpareparts(
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
  async getSales(
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
