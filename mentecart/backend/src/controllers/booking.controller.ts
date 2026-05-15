import { Response } from "express";
import { AuthRequest } from "../middleware/auth.middleware";
import { checkoutBooking } from "../services/booking.service";

export const checkout = async(
    req:AuthRequest,
    res:Response,
)=>{
    try{
        const booking= 
        await checkoutBooking(
            req.userId as string
        );

        res.status(201).json({
            success:true,
            data:booking,
        });
    }catch(error: any){
        res.status(409).json({
            success:false,
            message: error.message,
        });
    }
};