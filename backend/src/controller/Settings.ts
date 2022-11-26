import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";
const prisma = new PrismaClient();

export class SettingsController {
  async list(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const trigger: any =
      await prisma.$queryRaw`SELECT  is_disabled FROM sys.triggers WHERE name = 'create_invoice'`;

    const settings = {
      useTrigger: !trigger[0].is_disabled,
    };
    console.log(trigger);

    return res.json(settings);
  }

  async updateSettings(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
    const { useTrigger } = req.body;
    console.log(useTrigger);

    if (useTrigger) {
      console.log(
        await prisma.$executeRaw`
      USE trommelhelden;
      ENABLE TRIGGER create_invoice  ON Auftrag`
      );
    } else {
      await prisma.$executeRaw`
      USE trommelhelden;
      DISABLE TRIGGER create_invoice  ON Auftrag`;
    }

    res.sendStatus(200);
  }
}
