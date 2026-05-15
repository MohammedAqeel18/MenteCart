import express from "express";

import {
    addCartItem,
    getUserCart,
} from "../controllers/cart.controller";

import { protect } from "../middleware/auth.middleware";

const router = express.Router();

router.get("/", protect, getUserCart);

router.post("/items", protect, addCartItem);

export default router;