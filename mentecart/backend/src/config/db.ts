import mongoose from "mongoose";

export const connectDB = async()=>{
    try{
        await mongoose.connect(process.env.MONGO_URI as string);

        console.log("MongoDB Connected")
    }catch(errot){
        console.error("Database connection failed")
    process.exit(1);
    }
};