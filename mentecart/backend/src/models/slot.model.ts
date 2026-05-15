import mongoose from "mongoose";


const slotSchema = new mongoose.Schema(
    {
        service: {
            type: mongoose.Schema.Types.ObjectId,
            ref:"Service",
            required:true,
        },

        date:{
            type: String,
            required:true,
        },

        timeSlot: {
            type: String,
            required:true,
        },

        remainingCapacity: {
            type: Number,
            required: true,
            min:0,
        },
    },
    {
        timestamps:true,
    }
);
slotSchema.index(
    {
        service: 1,
        date:1,
        timeSlot:1,
    },

    {
        unique:true,
    }
);

export const Slot = mongoose.model(
    "slot",
    slotSchema
)