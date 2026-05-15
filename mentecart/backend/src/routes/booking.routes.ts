import express from "express";

import { checkout } from "../controllers/booking.controller";

import { protect } from "../middleware/auth.middleware";

const router = express.Router();

router.post(
    "/checkout",
    protect,
    checkout
);

export default router;