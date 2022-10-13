import { NextFunction, Request, Response } from "express";
import { Prisma, PrismaClient } from "@prisma/client";
import { Runtype } from "runtypes";
import { send } from "process";

const prisma = new PrismaClient();

export const getEmployees = async (req: Request, res: Response) => {
  try {
    console.log("Request received employees");

    const data = await prisma.mitarbeiter.findMany();

    return res.send(JSON.stringify(data));
  } catch (e) {
    return res.status(400).send(e);
  }
};

export const listTables = async (req: Request, res: Response, next: NextFunction) => {
  try {
    console.log("Request received");
    const data = await prisma.$queryRaw`SELECT * FROM INFORMATION_SCHEMA.TABLES `;
    return res.json(data);
  } catch (e) {
    return res.status(400).send(e);
  }
};

export class OrderController {
  async get(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      const { query } = req;

      console.log(query);

      if (id) {
        console.log("id");

        const orders = await prisma.auftrag.findMany({
          where: {
            Aufnr: Number(id),
            ...query,
          },
          include: {
            Kunde: true,
            Mitarbeiter: true,
            Montage: true,
            _count: true,
            Rechnung: true,
          },
        });
        return res.json(orders);
      } else {
        const orders = await prisma.auftrag.findMany({
          where: {
            ...query,
          },
          select: {
            Kunde: true,
            Mitarbeiter: {
              select: {
                NLNr: true,
                Niederlassung: true,
              },
            },
            Montage: {
              select: {
                Ersatzteil: {
                  select: {
                    EtBezeichnung: true,
                    EtAnzLager: true,
                    EtHersteller: true,
                    EtPreis: true,
                  },
                },
              },
            },
            _count: true,
            Rechnung: {
              select: {
                AufNr: true,
                Kunde: {
                  select: {
                    KunName: true,
                    KunStrasse: true,
                    KunNr: true,
                    KunPLZ: true,
                    KunOrt: true,
                  },
                },
                RechBetrag: true,
                RechDat: true,
              },
            },
          },
        });
        return res.json(orders);
      }
    } catch (err) {
      return next(err);
    }
  }
  async delete(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      const orders = await prisma.auftrag.delete({
        where: {
          Aufnr: Number(id),
        },
      });

      return res.json(orders);
    } catch (err) {
      return next(err);
    }
  }
  async update(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      console.log(req.body);

      const { data }: { data: Prisma.AuftragUpdateInput } = req.body;

      const orders = await prisma.auftrag.updateMany({
        data,
        where: {
          Aufnr: Number(id),
        },
      });

      return res.json(orders);
    } catch (err) {
      return next(err);
    }
  }
}
