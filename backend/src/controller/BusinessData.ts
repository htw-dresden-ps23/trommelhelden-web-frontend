import { Prisma, PrismaClient, Rechnung , Auftrag, Montage} from "@prisma/client";
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
              //Math.max()
              RechBetrag: true,
            },
            _count: {
              RechBetrag: true,
            },
            _min: {
              //Math.min()
              RechBetrag: true,
            },
            where: {
              ...filter,
            },
          });
        }

        break;
      case "backend": {
        const rechnungen: Rechnung[] = await prisma.rechnung.findMany();
        let avg,
          max,
          count,
          min,
          sum: number = 0;
        let array: any = [];
        rechnungen.forEach((rechnung) => {
          sum += rechnung.RechBetrag;
          array.push(rechnung.RechBetrag);
        });
        count = rechnungen.length;
        avg = sum / count;
        console.log(array);
        max = Math.max(...array);
        min = Math.min(...array);

        data = {
         
            _avg: {
              RechBetrag: avg,
            },
            _sum: {
              RechBetrag: sum,
            },
            _max: {
              //Math.max()
              RechBetrag: max,
            },
            _count: {
              RechBetrag: count,
            },
            _min: {
              //Math.min()
              RechBetrag: min,
            }
        };
        console.log(data);
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
          const auftraege: Auftrag[] = await prisma.auftrag.findMany();
          let avgAnfahrt, avgDauer,
            maxDauer, maxAnfahrt,
            countAnfahrt, countDauer,
            minDauer, minAnfahrt,
            sumAnfahrt: any | number = 0   , sumDauer: any | number = 0;
          let arrayAnfahrt: any = [];
          let arrayDauer: any = [];
          auftraege.forEach((auftrag) => {
            if (auftrag.Anfahrt !== 0 && auftrag.Anfahrt !== null && auftrag.Anfahrt !== undefined|| auftrag.Dauer !== null && auftrag.Dauer !== undefined){
              sumAnfahrt += auftrag.Anfahrt;
              // auftrag.Dauer = Math.round(auftrag.Dauer)
              sumDauer += auftrag.Dauer;
              sumAnfahrt += auftrag.Anfahrt;
         
            }
            
            arrayAnfahrt.push(auftrag.Anfahrt);
            arrayDauer.push(auftrag.Dauer);
          });
          countAnfahrt = arrayAnfahrt.length;
          countDauer = arrayDauer.length;
          avgAnfahrt = sumAnfahrt / countAnfahrt;
          avgDauer = sumDauer / countDauer;
     
          maxAnfahrt = Math.max(...arrayAnfahrt);
          minAnfahrt = Math.min(...arrayAnfahrt);
          maxDauer = Math.max(...arrayDauer);
          minDauer = Math.min(...arrayDauer);
  
          data = {
           
            _avg: {
              Anfahrt: avgAnfahrt,
              Dauer: avgDauer,
            },
            _sum: {
              Anfahrt: sumAnfahrt,
              Dauer: sumDauer,
            },
            _max: {
              Anfahrt: maxAnfahrt,
              Dauer: maxDauer,
            },
            _count: {
              Anfahrt: countAnfahrt,
              Dauer: countDauer,
            },
            _min: {
              Anfahrt: minAnfahrt,
              Dauer: minAnfahrt,
            }
          };
          console.log(data);
          break;
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
        const montagen: Montage[] = await prisma.montage.findMany();
        let avg,
          max,
          count,
          min,
          sum: number = 0;
        let array: any = [];
        montagen.forEach((montage) => {
          sum += montage.Anzahl;
          array.push(montage.Anzahl);
        });
        count = montagen.length;
        avg = sum / count;
        console.log(array);
        max = Math.max(...array);
        min = Math.min(...array);

        data = {
         
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
        };
        console.log(data);
        break;
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
