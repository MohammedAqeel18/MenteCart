import { Request, Response } from "express";
import { generatePayHereHash } from '../services/payment.services';

export const createCheckout = async (
  req: Request,
  res: Response
) => {
  try {
    const { orderId, amount } = req.body;

    const hash = generatePayHereHash(
      orderId,
      amount,
      "LKR"
    );

    res.json({
      success: true,
      data: {
        merchantId: process.env.PAYHERE_MERCHANT_ID,
        orderId,
        amount,
        currency: "LKR",
        hash,
      },
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Checkout failed",
    });
  }
};