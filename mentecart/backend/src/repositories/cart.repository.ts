import { Cart  } from "../models/cart.model";

export const getCartByUserRepository = async (
    userId: string
) => {
    return Cart.findOne({user: userId}).populate(
        "items.service"
    );
};

export const createCartRepository =  async(
    userId: string
)=> {
    return Cart.create({
        user:userId,
        items:[],
    });
};

export const saveCartRepository = async (
    cart: any
) => {
    return cart.save();
};