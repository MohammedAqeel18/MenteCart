import { Booking } from "../models/booking.model";
import { Cart } from "../models/cart.model";
import { Slot } from "../models/slot.model";
import {
    getBookingsByUserRepository,
    getBookingByIdRepository
} from "../repositories/booking.repository";


export const getUserBookings = async (userId: string)=> {
    return await getBookingsByUserRepository(userId);
}

export const getBookingDetails = async (bookingId: string) =>{

    const booking = await getBookingByIdRepository(bookingId);

if(!booking){
    throw new Error("Booking not found");
}

return booking;

};


export const checkoutBooking = async (
    userId: string
) => {
    const cart = await Cart.findOne({
        user: userId,
    }).populate("items.service");

    if(!cart || cart.items.length === 0){
        throw new Error("Cart is empty");
    }

    let totalAmount = 0;

    for(const item of cart.items){
        const updatedSlot = 
        await Slot.findOneAndUpdate(
            {
                service:item.service._id,
                date: item.date,
                timeSlot:item.timeSlot,
                remainingCapacity:{
                    $gte: item.quantity,
                },
            },
            {
                $inc :{
                    remainingCapacity: -item.quantity,
                },
            },

            {
                new : true,
            }
        );

        if(!updatedSlot){
            throw new Error(
                `slot unavailable for ${item.timeSlot}`
            );
        }
        totalAmount += item.price *item.quantity;
    }

    const booking = await Booking.create({
        user:userId,
        items: cart.items,
        totalAmount,
        status:"confirmed",
        paymentMethod :"cash",
        paymentStatus :"pending",
        });

        cart.items.splice (0, cart.items.length);

        await cart.save();

        return booking;
}


export const cancelBooking = async(
    userId : string,
    bookingId: string
)=> {

    const booking = await Booking.findOne({
        _id:bookingId,
        user: userId,
    });

    if(!booking){
        throw new Error("Booking not found");
    }

    if(booking.status !== "confirmed"){
        throw new Error("Cannot cancel this booking");
    }

    for (const item of booking.items){
        await Slot.findByIdAndUpdate(
            {
                service: item.service,
                date: item.date,
                timeSlot: item.timeSlot,
        },
        {
            $inc:{
                remainingCapacity:item.quantity,
            },
        }
    );
    }

    booking.status = "cancelled";

    await booking.save();

    return Booking;
};