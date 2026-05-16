import { Request, Response } from "express";
import crypto from "crypto";
import { payhereConfig } from "../config/payhere.config";

export const payhereWebhook = async (
  req: Request,
  res: Response
) => {
  try {
    const {
      merchant_id,
      order_id,
      payment_id,
      status_code,
      md5sig,
    } = req.body;

    const localSig = crypto
      .createHash("md5")
      .update(
        merchant_id +
          order_id +
          payment_id +
          status_code +
          crypto
            .createHash("md5")
            .update(payhereConfig.merchantSecret)
            .digest("hex")
            .toUpperCase()
      )
      .digest("hex")
      .toUpperCase();

    if (localSig !== md5sig) {
      return res.status(400).json({
        message: "Invalid signature",
      });
    }

    if (status_code === "2") {
      
      console.log("Payment success:", order_id);

      
    }

    res.status(200).json({
      message: "Webhook received",
    });
  } catch (error) {
    res.status(500).json({
      message: "Webhook error",
    });
  }
};