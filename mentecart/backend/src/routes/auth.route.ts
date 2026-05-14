import express from "express";
import { protect } from "../middleware/auth.middleware";
import { getUser } from "../controllers/auth.controller";


import {
    login,
    signup
} from "../controllers/auth.controller";

const router = express.Router();

router.post("/signup", signup);

router.post("/login" , login);

router.post("/user", protect, getUser);

export default router;
