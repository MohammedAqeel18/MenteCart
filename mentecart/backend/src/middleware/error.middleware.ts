import { Request,Response,NextFunction } from "express";
import { success } from "zod";

export const errorHandler = (
    err:any,
    req:Request,
    res:Response,
    next: NextFunction
) => {
    const statusCode = err.statusCode || 500;

    res.status(statusCode).json({
        success:false,
        message:err.message || "Internal Server Error",
    });
};

