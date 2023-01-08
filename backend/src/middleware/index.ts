import { Prisma } from "@prisma/client";
import express, { NextFunction, Request, Response } from "express";

export const prismaErrorMiddleware = (
  error: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (!error) {
    return next();
  }

  if (error instanceof Prisma.PrismaClientValidationError) {
    console.log("Error Validation", error.message);
    return res.status(400).json({ error: error.message });
  }
  if (error instanceof Prisma.PrismaClientKnownRequestError) {
    console.log("Error PrismaClientKnownRequestError", error.message);
    return res
      .status(400)
      .json({ error: error.message, code: error.code, meta: error.meta });
  }
  if (error instanceof Prisma.PrismaClientUnknownRequestError) {
    console.log("Error PrismaClientUnknownRequestError", error.message);
    return res.status(400).json({ error: error.message });
  }

  console.log(error);

  res.status(500);
  res.send("500: Internal server error");
};
