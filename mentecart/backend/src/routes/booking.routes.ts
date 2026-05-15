import express from "express";

import { checkout,getBookings,getBooking,cancel } from "../controllers/booking.controller";

import { protect } from "../middleware/auth.middleware";

const router = express.Router();

router.post(
    "/checkout",
    protect,
    checkout
);

router.get("/", protect, getBookings);

router.get("/:id", protect,getBooking);

router.post("/:id/cancel", protect, cancel);

export default router;