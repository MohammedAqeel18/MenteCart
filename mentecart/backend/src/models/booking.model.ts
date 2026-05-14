import mongoose from "mongoose";


const bookingItemSchema = new mongoose.Schema(
    {
        service:{
            type: mongoose.Schema.Types.ObjectId,
            ref:"Service",
            required:true,
        },

        date:{
            type:String,
            required:true,
        },

        timeSlot:{
            type:String,
            required:true,
        },
        quantity:{
            type:Number,
            required:true,
        },
        price:{
            type:Number,
            required:true,
        },
    },
    {
        _id:false,
    }
);

const bookingSchema = new mongoose.Schema(
    {
        user:{
            type:mongoose.Schema.Types.ObjectId,
            ref:"User",
            required:true,
        },

        items:[bookingItemSchema],

        totalAmount:{
            type:Number,
            required:true,
        },

        status:{
            type:String,
            enum:[
                "pending",
                "confirmed",
                "completed",
                "cancelled",
                "failed",
            ],

            default:"pending",
        },
        
        paymentMethod:{
            type:String,
            enum: ["cash", "pay_on_arrival"],
            default:"cash",
        },

        paymentStatus:{
            type:String,
            enum:["pending", "paid","failed"],
            default:"pending",
        },
    },
    {
        timestamps:true,
    }
);

export const Booking = mongoose.model(
    "Booking",
    bookingSchema
);