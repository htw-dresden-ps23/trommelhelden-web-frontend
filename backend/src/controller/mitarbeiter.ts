import { NextFunction, Request, Response } from "express";
import { Prisma, PrismaClient } from "@prisma/client";
import { Runtype } from "runtypes";
import { send } from "process";

const prisma = new PrismaClient();

export class EmployeesController {
  async list(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { sort, filter, page, rows } = req.body
      console.log(req.body)
      const allEmployees = await prisma.mitarbeiter.findMany(
        {
        take: rows , 
        skip: rows * page,
        where:{
          ...filter
        },
        orderBy: [
          ...sort
        ]
        }
       
      );
      // console.log(allEmployees[0])
      if(allEmployees.length > 0) {
        return res.status(200).json(allEmployees);
      }
      return res.status(500).send('Keine Mitarbeiter gefunden')
    } catch (err) {
      console.log(err)
       await prisma.$disconnect()
      return next(err);
    }
  }
  async delete(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      const employee = await prisma.mitarbeiter.delete({
        where: {

        },
      });

      return res.json(employee);
    } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
  async update(req: Request, res: Response, next: NextFunction): Promise<Response | void> {
    try {
      const { id } = req.params;
      console.log(req.body);

      const { data }: { data: Prisma.AuftragUpdateInput } = req.body;

      const employee = await prisma.mitarbeiter.updateMany({
        data,
        where: {
          
        },
      });

      return res.json(employee);
    } catch (err) {
      await prisma.$disconnect()
      return next(err);
    }
  }
}