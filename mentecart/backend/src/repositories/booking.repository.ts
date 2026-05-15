import { Booking } from "../models/booking.model";

export const createBookingRepository = async (data: any) =>{
    return Booking.create(data);
};

export const getBookingsByUserRepository = async (userId: string)=>{

    return Booking.find({ user : userId})
    .sort({createdAt: -1});
};

export const getBookingByIdRepository = async (id: string)=>{
    return Booking.findById(id).populate("items.service");
};

