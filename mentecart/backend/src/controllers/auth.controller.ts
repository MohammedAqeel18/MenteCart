import { Request, Response } from "express";

import { AuthRequest } from "../middleware/auth.middleware";

import {
  getCurrentUser,
  loginUser,
  signupUser,
} from "../services/auth.service";

import logger from "../utils/logger";

import {
  loginSchema,
  signupSchema,
} from "../validators/auth.validators";

import { asyncHandler } from "../utils/asyncHandler";

export const signup = asyncHandler(
  async (req: Request, res: Response) => {

    logger.info({
      requestId: req.id,
      message: "Signup attempt",
      email: req.body.email,
    });

    const validatedData =
      signupSchema.parse(req.body);

    const result = await signupUser(
      validatedData.name,
      validatedData.email,
      validatedData.password
    );

    logger.info({
      requestId: req.id,
      message: "Signup success",
      userEmail: validatedData.email,
    });

    res.status(201).json({
      success: true,
      data: result,
    });
  }
);

export const login = asyncHandler(
  async (req: Request, res: Response) => {

    logger.info({
      requestId: req.id,
      message: "Login attempt",
      email: req.body.email,
    });

    const validatedData =
      loginSchema.parse(req.body);

    const result = await loginUser(
      validatedData.email,
      validatedData.password
    );

    logger.info({
      requestId: req.id,
      message: "Login success",
      userEmail: validatedData.email,
    });

    res.status(200).json({
      success: true,
      data: result,
    });
  }
);

export const getUser = async (
  req: AuthRequest,
  res: Response
) => {

  try {

    logger.info({
      requestId: req.id,
      message: "Fetch current user",
      userId: req.userId,
    });

    const user = await getCurrentUser(
      req.userId as string
    );

    logger.info({
      requestId: req.id,
      message: "Current user fetched successfully",
      userId: req.userId,
    });

    res.status(200).json({
      success: true,
      data: user,
    });

  } catch (error: any) {

    logger.error({
      requestId: req.id,
      message: "Fetch current user failed",
      error: error.message,
      userId: req.userId,
    });

    res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};