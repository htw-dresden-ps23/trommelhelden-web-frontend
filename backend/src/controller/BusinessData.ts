import {
  Auftrag,
  Mitarbeiter,
  Montage,
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
        // const mitarbeiter: Mitarbeiter[] = await prisma.mitarbeiter.findMany();
        // const auftraege: Auftrag[] = await prisma.auftrag.findMany();
        // const rechnungen: Rechnung[] = await prisma.rechnung.findMany();

        // let umsatz: any = 0;
        // let foundAuftraege: any = [];
        // let foundMitarbeiter: any = mitarbeiter.find(
        //   (mitarbeiter) => mitarbeiter.MitID === filter
        // );
        // console.log(foundMitarbeiter);

        // auftraege.forEach((auftrag: Auftrag) => {
        //   if (auftrag.MitID === foundMitarbeiter.MitID) {
        //     foundAuftraege.push(auftrag);
        //   }
        // });

        // for (let auftrag of foundAuftraege) {
        //   let foundRechnung: any = rechnungen.find(
        //     (rechnung) => rechnung.AufNr === auftrag.Aufnr
        //   );
        //   if (foundRechnung !== undefined) {
        //     console.log(foundRechnung.RechBetrag);
        //     umsatz += foundRechnung.RechBetrag;
        //   }
        // }
        // data = umsatz;

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
        // const auftraege: Auftrag[] = await prisma.auftrag.findMany();
        // let avgAnfahrt,
        //   avgDauer,
        //   maxDauer,
        //   maxAnfahrt,
        //   countAnfahrt,
        //   countDauer,
        //   minDauer,
        //   minAnfahrt,
        //   sumAnfahrt: any | number = 0,
        //   sumDauer: any | number = 0;
        // let arrayAnfahrt: any = [];
        // let arrayDauer: any = [];
        // auftraege.forEach((auftrag) => {
        //   if (
        //     (auftrag.Anfahrt !== 0 &&
        //       auftrag.Anfahrt !== null &&
        //       auftrag.Anfahrt !== undefined) ||
        //     (auftrag.Dauer !== null && auftrag.Dauer !== undefined)
        //   ) {
        //     sumAnfahrt += auftrag.Anfahrt;
        //     // auftrag.Dauer = Math.round(auftrag.Dauer)
        //     sumDauer += auftrag.Dauer;
        //     sumAnfahrt += auftrag.Anfahrt;
        //   }
        //   arrayAnfahrt.push(auftrag.Anfahrt);
        //   arrayDauer.push(auftrag.Dauer);
        // });
        // countAnfahrt = arrayAnfahrt.length;
        // countDauer = arrayDauer.length;
        // avgAnfahrt = sumAnfahrt / countAnfahrt;
        // avgDauer = sumDauer / countDauer;
        // maxAnfahrt = Math.max(...arrayAnfahrt);
        // minAnfahrt = Math.min(...arrayAnfahrt);
        // maxDauer = Math.max(...arrayDauer);
        // minDauer = Math.min(...arrayDauer);
        // data = {
        //   _avg: {
        //     Anfahrt: avgAnfahrt,
        //     Dauer: avgDauer,
        //   },
        //   _sum: {
        //     Anfahrt: sumAnfahrt,
        //     Dauer: sumDauer,
        //   },
        //   _max: {
        //     Anfahrt: maxAnfahrt,
        //     Dauer: maxDauer,
        //   },
        //   _count: {
        //     Anfahrt: countAnfahrt,
        //     Dauer: countDauer,
        //   },
        //   _min: {
        //     Anfahrt: minAnfahrt,
        //     Dauer: minAnfahrt,
        //   },
        // };
        // console.log(data);
        // break;
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

      case "backend": {
        // const montagen: Montage[] = await prisma.montage.findMany();
        // let avg,
        //   max,
        //   count,
        //   min,
        //   sum: number = 0;
        // let array: any = [];
        // montagen.forEach((montage) => {
        //   sum += montage.Anzahl;
        //   array.push(montage.Anzahl);
        // });
        // count = montagen.length;
        // avg = sum / count;
        // console.log(array);
        // max = Math.max(...array);
        // min = Math.min(...array);
        // data = {
        //   _count: {
        //     Anzahl: true,
        //   },
        //   _avg: {
        //     Anzahl: true,
        //   },
        //   _sum: {
        //     Anzahl: true,
        //   },
        //   where: {
        //     ...filter,
        //   },
        // };
        // console.log(data);
        // break;
        // // BERECHNEN IM BACKEND
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
