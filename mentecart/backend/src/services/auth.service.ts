import bcrypt from "bcrypt";
import {User} from "../models/user.model";
import { generateToken } from "../utils/generateToken";
import { AppError } from "../utils/AppError";


export const  signupUser = async (
    name:string,
    email: string,
    password: string
)=>{

    const existingUser = await User.findOne({email});

    if (existingUser) {
        throw new Error ("Email already exists");
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.create({
        name,
        email,
        password: hashedPassword,
    });

    const token = generateToken(user._id.toString());

    return{
        token,
        user,
    };
};



export const loginUser = async (
    email: string,
    password: string
) =>{
    const user = await User.findOne({ email});

    if (!user){
        throw new AppError("Invalid credintials", 401);
    }

    const isPasswordMatched = await bcrypt.compare(
        password,
        user.password
    );

    if(!isPasswordMatched){
        throw new AppError("Invalid Credentials", 401);
    }

    const token = generateToken(user._id.toString());

    return{
        token,
        user,
    };
};


export const getCurrentUser = async(
    userId: string 
)=> {

    const user = await User.findById(userId).select(
        "-password"
    );

    if(!user){
        throw new Error("User not found");
    }

    return user;

}