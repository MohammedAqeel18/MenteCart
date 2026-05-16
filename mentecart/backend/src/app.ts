import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import { connectDB } from "./config/db";
import authRoutes from "./routes/auth.route";
import serviceRoutes from "./routes/service.routes";
import cartRoutes from "./routes/cart.routes";
import bookingRoutes from "./routes/booking.routes";
import paymentRoutes from "./routes/payment.routes";
import { errorHandler } from "./middleware/error.middleware";
import loggerMiddleware from "./middleware/loggerMiddleware";



dotenv.config();

const app = express();

connectDB();

app.use(cors());
app.use(loggerMiddleware);
app.use(express.json());


app.use("/api/auth", authRoutes);

app.use("/api/services", serviceRoutes);

app.use("/api/cart", cartRoutes);

app.use("/api/bookings", bookingRoutes);

app.use("/api/payments", paymentRoutes);
app.get("/", (req,res)=>{
    res.json({
        message:" MenteCart API running"
    })
})

app.use((req , res ) => {
    res.status(404).json({
        success:false,
        message:"Route not found"
    });
});

app.use(errorHandler);


const PORT = process.env.PORT || 5000;

app.listen(PORT, ()=>{
    console.log(`Server is running on PORT ${PORT}`)
});