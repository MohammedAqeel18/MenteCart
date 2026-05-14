import mongoose from "mongoose";




const serviceSchema = new mongoose.Schema(
    {
        title:{
            type:String,
            required:true,
            trim: true,
        },

        descreption:{
            type: String,
            required:true,
        },

        price:{
            type:Number,
            required:true,
},

        duration:{

        type:Number,
        required:true,
},

        category:{
            type:String,
            required: true,
        },

        image:{
            type: String,
            required: true,
        },

        capacityPerSlot: {
            type: Number,
            required: true,
            default:1,
        },
    },
    {
        timestamps:true,
    }
);

export const Service = mongoose.model(
    "Service",
    serviceSchema
);