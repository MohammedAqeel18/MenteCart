import crypto from "crypto";
import { payhereConfig } from "../config/payhere.config";

export const generatePayHereHash = (
  orderId: string,
  amount: number,
  currency: string
) => {
  const merchantSecret = crypto
    .createHash("md5")
    .update(payhereConfig.merchantSecret)
    .digest("hex")
    .toUpperCase();

  const hash = crypto
    .createHash("md5")
    .update(
      payhereConfig.merchantId +
        orderId +
        amount +
        currency +
        merchantSecret
    )
    .digest("hex")
    .toUpperCase();

  return hash;
};