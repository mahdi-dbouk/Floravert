import { AuthRequest } from "./auth.middleware.js";
import { Response, NextFunction } from "express";
import User from "../models/user.model.js";


export const isTrader = async (req: AuthRequest, res: Response, next: NextFunction) => {
    const _id = req.user._id;
    const user = await User.findOne({_id});

    if(!user) {
        return res.status(404).json({
            message: "user not found"
        });
    }

    if(!user.isTrader){
        return res.status(401).json({
            message: "Unauthorized",
            isTrader: false
        });
    }

    next();
    
}