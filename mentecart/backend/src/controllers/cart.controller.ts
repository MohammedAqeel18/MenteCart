import { Response } from "express";

import { AuthRequest } from "../middleware/auth.middleware";

import {
    addItemToCart,
    getCart,
} from "../services/cart.service";
import { success } from "zod";

export const getUserCart = async(
    req: AuthRequest,
    res: Response
) =>{
    try{
        const cart = await getCart(
            req.userId as string
        );

        res.status(200).json({
            success: true,
            data:cart,
        });
    }catch(error: any){
        res.status(500).json({
            success:false,
            message:error.message
        });
    }
};

export const addCartItem = async (
    req: AuthRequest,
    res:Response
) => {
    try{
        const{
            serviceId,
            date,
            timeSlot,
            quantity,
        } = req.body;

        const cart = await addItemToCart(
            req.userId as string,
            serviceId,
            date,
            timeSlot,
            quantity
        );

        res.status(201).json({
            success:true,
            data:cart,
        });
    }catch(error: any){
        res.status(400).json({
            success:false,
            message:error.message,
        });
    }
};