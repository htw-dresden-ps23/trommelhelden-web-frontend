import {
  Auftrag,
  Mitarbeiter,
  Montage,
  Niederlassung,
  Prisma,
  PrismaClient,
  Rechnung,
  Kunde,
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
    //     A.MitID,
    //     M.MitName,
    //     avg(A.Anfahrt) as avg_Anfahrt,
    //     max(A.Anfahrt) as max_Anfahrt,
    //     min(A.Anfahrt) as min_Anfahrt,
    //     sum(A.Anfahrt) as sum_Anfahrt,
    //     avg(A.Dauer) as avg_Dauer,
    //     max(A.Dauer) as max_Dauer,
    //     min(A.Dauer) as min_Dauer,
    //     sum(A.Dauer) as sum_Dauer,
    //     avg(R.RechBetrag) as avg_RechBetrag,
    //     max(R.RechBetrag) as max_RechBetrag,
    //     min(R.RechBetrag) as min_RechBetrag,
    //     sum(R.RechBetrag) as sum_RechBetrag
    // FROM Auftrag A
    //     INNER JOIN Mitarbeiter M
    //     ON A.MitID = M.MitID
    //     LEFT JOIN Rechnung R
    //     ON R.AufNr = A.Aufnr
    //     LEFT JOIN KUNDE K
    //     ON K.KunNr = A.KunNr
    //     LEFT JOIN Niederlassung N
    //     ON N.NLNr = M.NLNr

        // const auftraege : Auftrag [] = await prisma.auftrag.findMany();
        // const mitarbeiter: Mitarbeiter[] = await prisma.mitarbeiter.findMany();
        // const rechnungen: Rechnung[] = await prisma.rechnung.findMany();
        // const kunden: Kunde[] = await prisma.kunde.findMany();
        // const niederlassung: Niederlassung[] = await prisma.niederlassung.findMany();
        
        // let avg_Anfahrt:any,max_Anfahrt:any,min_Anfahrt,sum_Anfahrt,avg_Dauer,max_Dauer,min_Dauer,sum_Dauer,
        // avg_RechBetrag,max_RechBetrag, min_RechBetrag;
      
        // avg_Anfahrt = auftraege.reduce((a:any, b:any) => (a + b.Anfahrt ) / auftraege.length, 0 ) ;
        // console.log("AVG",avg_Anfahrt ); 

        // max_Anfahrt = Math.max(auftraege['Anfahrt']);
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
