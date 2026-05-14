import { Request, Response } from "express";
import { AuthRequest } from "../middleware/auth.middleware";
import{getCurrentUser} from "../services/auth.service";


import {
    loginUser,
    signupUser,
} from "../services/auth.service";

import {
    loginSchema,
    signupSchema,
} from "../validators/auth.validators";
import { success } from "zod";

export const signup = async (
    req: Request,
    res: Response
)=> {
    try{
        const validateData = signupSchema.parse(req.body);

        const result = await signupUser(
            validateData.name,
            validateData.email,
            validateData.password
        );

        res.status(201).json({
            success: true,
            data: result,
        });
    }catch(error:any){
        res.status(400).json({
            success: false,
            message: error.message,
        });
    }
};

export const login = async(
    req: Request,
    res: Response
) =>{
    try {
        const validatedData = loginSchema.parse(req.body);

        const result = await loginUser(
            validatedData.email,
            validatedData.password
        );

        res.status(200).json({
            success:true,
            data:result,
        });
    } catch(error: any){
        res.status(400).json({
            success: false,
            message: error.message,
        });
    }
};


export const getUser = async(
    req: AuthRequest,
    res: Response
) => {

    try{
        const user = await getCurrentUser(
            req.userId as string
        );

        res.status(200).json({

            success:true,
            data:user,
        });
    }catch(error: any){
        res.status(400).json({
            success:false,
            message:error.message,
        });
    }
};