import { Booking } from "../models/booking.model";
import { Cart } from "../models/cart.model";
import { Slot } from "../models/slot.model";

export const checkoutBooking = async(
    userId: string
) => {
    const cart = await Cart.findOne({
        user:userId,
    });

    if(!cart){
        throw new Error("Cart is empty")
    }

    if(cart.items.length === 0){
        throw new Error("Cart is empty");
    }

    let totalAmount = 0;

    for(const item of cart.items){
        const slot = 
            await Slot.findOneAndUpdate(
                {
                    service:item.service,
                    date:item.date,
                    timeSlot: item.timeSlot,
                    remainingCapacity:{
                        $gte: item.quantity,
                    },
                },
                {
                    $inc:{
                        remainingCapacity: -item.quantity,
                    },
                },
                {
                    new: true,
                }
            );

            if(!slot){
                throw new Error(
                    `Slot unavailable for ${item.timeSlot}`
                );
            }

            totalAmount += item.price * item.quantity;
    }

    const booking = await Booking.create({
        user:userId,
        items:cart.items,
        totalAmount,
        status: "confirmed",
        paymentMethod:"cash",
        paymentStatus:"pending",
    });

    cart.items = [];

    await cart.save();

    return booking;
};