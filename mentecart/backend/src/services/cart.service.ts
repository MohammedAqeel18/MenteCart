import { Service } from "../models/service.model";

import {
    createCartRepository,
    getCartByUserRepository,
    saveCartRepository,
} from "../repositories/cart.repository";

export const getCart = async(
    userId: string
) => {
    let cart = 
    await getCartByUserRepository(userId);

    if(!cart){
        cart = await createCartRepository(userId);
    }

    return cart;
};

export const addItemToCart = async(
    userId: string,
    serviceId: string,
    date: string,
    timeSlot: string,
    quantity: number
) => {
    const service = await Service.findById(
        serviceId
    );

    if(!service){
        throw new Error("Service not found")
    }

    let cart = 
    await getCartByUserRepository(userId);

    if(!cart){
        cart = await createCartRepository(userId);
    }

    const existingItem = cart.items.find(
        (item: any) =>
            item.service.toString() == serviceId &&
            item.data === date &&
            item.timeSlot === timeSlot
        
    );

    if(existingItem){
        throw new Error(
            "Service already added for this slot"
        );
    }

    cart.items.push({
        service: service._id,
        date,
        timeSlot,
        quantity,
        price:service.price,
    });

    await saveCartRepository(cart);

    return cart;
}