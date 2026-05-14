import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import { connectDB } from "./config/db";
import authRoutes from "./routes/auth.route";
import serviceRoutes from "./routes/service.routes";
import cartRoutes from "./routes/cart.routes";

dotenv.config();

const app = express();

connectDB();

app.use(cors());
app.use(express.json());


app.use("/api/auth", authRoutes);

app.use("/api/services", serviceRoutes);

app.use("/api/cart", cartRoutes);

app.get("/", (req,res)=>{
    res.json({
        message:" MenteCart API running"
    })
})

const PORT = process.env.PORT || 5000;

app.listen(PORT, ()=>{
    console.log(`Server is running on PORT ${PORT}`)
});