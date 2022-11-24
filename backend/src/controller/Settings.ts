import { Prisma, PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { send } from "process";
import { Runtype } from "runtypes";
const prisma = new PrismaClient();

export class SettingsController {
  async toggleInvoiceGenerator(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<Response | void> {
      
      const { useTrigger } = req.body;
      

      if (useTrigger) {
          prisma.$executeRaw`ENABLE TRIGGER create_invoice  
      `
      
      
      
  }
}
