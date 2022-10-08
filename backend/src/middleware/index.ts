import express, { NextFunction, Request, Response } from "express";
import { Prisma } from "@prisma/client";

export const prismaErrorMiddleware = (error: any, req: Request, res: Response, next: NextFunction) => {
  if (error instanceof Prisma.PrismaClientValidationError) {
    return res.status(400).json({ error: error.message });
  }
  if (error instanceof Prisma.PrismaClientKnownRequestError) {
    return res.status(400).json({ error: error.message, code: error.code, meta: error.meta });
  }
  if (error instanceof Prisma.PrismaClientUnknownRequestError) {
    return res.status(400).json({ error: error.message });
  }

  next();
};
