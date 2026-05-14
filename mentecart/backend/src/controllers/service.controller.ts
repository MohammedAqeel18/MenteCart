import { Request, Response } from "express";
import { getAllServices, getSingleService } from "../services/service.service";
import { success } from "zod";

export const getServices = async (
    req: Request,
    res:Response
) => {
    try{
        const page = Number(req.query.page) || 1;

        const limit = 
        Number(req.query.limit) || 10;

        const category = req.query.category as string;

        const search = req.query.search as string;

        const result = await getAllServices(
            page,
            limit,
            category,
            search
        );

        res.status(200).json({
            success:true,
            data:result,
        });
    } catch(error: any){
        res.status(500).json({
            success: false,
            message: error.message,
        });
    }
};

export const getServiceById = async (
    req:Request,
    res : Response
) => {

    try{
        const service = await getSingleService(
            req.params.id as string
        );

        res.status(200).json({
            success:true,
            data:service,
        });
    }catch(error: any){
        res.status(404).json({
            success: false,
            message: error.message,
        });
    }
};