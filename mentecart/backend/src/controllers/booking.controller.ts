import { Response } from "express";
import { AuthRequest } from "../middleware/auth.middleware";
import { checkoutBooking } from "../services/booking.service";
import { getUserBookings, getBookingDetails, cancelBooking } from "../services/booking.service";
import { success } from "zod";


export const getBookings = async (req: any, res:any)=>{
    try{
        const bookings = await getUserBookings(req.userId);

        res.json({
            success:true,
            data:bookings,
        });
    } catch(err: any){
        res.status(500).json({
            success:false,
            message:err.message,
        });
    }
};

export const getBooking = async (req: any, res:any)=> {
    try{
        const booking = await getBookingDetails(req.params.id);

        res.json({
            success:true,
            data:booking,
        });
    }catch (err: any){
        res.status(404).json({
            success:false,
            message: err.message,
        });
    }
};

export const cancel = async (req: any, res:any)=> {
    try{
        const booking = await cancelBooking(
            req.userId,
            req.params.id
        );

        res.json({
            success:true,
            data:booking,
        });
    }catch(err:any){
        res.status(400).json({
            success:false,
            message:err.message,
        });
    }
};



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