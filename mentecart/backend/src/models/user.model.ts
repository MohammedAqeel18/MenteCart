import mongoose from "mongoose";
import { type } from "node:os";
import { email, lowercase } from "zod";
import { required } from "zod/mini";

const userSchema = new mongoose.Schema(
    {
        name: {
            type :String,
            required:true,
            trim:true,
        },

        email:{
            type:String,
            required:true,
            unique:true,
            lowercase:true,

        },

        password:{
            type:String,
            required:true,
        },
    },
    {
        timestamps:true,
    }
);

export const User = mongoose.model("User", userSchema);