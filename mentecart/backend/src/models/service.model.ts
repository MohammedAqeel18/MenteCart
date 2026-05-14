import mongoose from "mongoose";
import { type } from "node:os";
import { string } from "zod";
import { required } from "zod/mini";

const serviceSchema = new mongoose.Schema(
    {
        title:{
            type:string,
            required:true,
            trim: true,
        },

        descreption:{
            type: string,
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
            type:string,
            required: true,
        },

        image:{
            type: string,
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