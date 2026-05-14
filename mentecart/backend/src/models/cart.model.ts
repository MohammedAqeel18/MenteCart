import mongoose from "mongoose";



const cartItemsSchema = new mongoose.Schema(
    {
        service:{
            type: mongoose.Schema.Types.ObjectId,
            ref:"Service",
            required:true,
        },

        date:{
            type: String,
            required: true,
        },

        timeSlot:{
            type: String,
            required: true,
        },

        quantity:{
            type: Number,
            required: true,
        },
        price:{
            type:Number,
            required:true,
        },
    },

    {
        _id:true,
    }
);

const cartSchema = new mongoose.Schema(
    {
        user:{
            type:mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: true,
            unique:true,
        },

        items:[cartItemsSchema],
    },
    {
        timestamps:true,
    }
);

export const Cart = mongoose.model(
    "Cart",
    cartSchema
);