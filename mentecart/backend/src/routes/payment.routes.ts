import express from "express";
import {
  createCheckout,
} from "../controllers/payment.controller";

import {
  payhereWebhook,
} from "../controllers/webhook.controller";

const router = express.Router();

router.post("/checkout", createCheckout);
router.post("/webhook", payhereWebhook);

export default router;