import {Request, Response, NextFunction } from 'express';
import 'dotenv/config';
import jsonwebtoken, {Secret, JwtPayload} from 'jsonwebtoken';
const jwt: typeof jsonwebtoken =  jsonwebtoken;

export interface AuthRequest extends Request {
    user?: JwtPayload;
}

export const blackList: string[] = []; 

export const isAuthorized = async (req: AuthRequest, res: Response, next: NextFunction) => {
    const token = req.headers.authorization?.split(" ")[1];
    
    //verify the token
    if(!token || blackList.includes(token)){
        return res.status(403).json({message: "Unauthorized"});
    }

    try {
        const secret: Secret = process.env.JWT_SECRET_KEY;
        const decoded = jwt.verify(token, secret);

        //attach auth user to request
        req.user = decoded as JwtPayload;
        next();

    } catch (error) {
        console.log(error);
    }
}

export const revokeToken = (token: string) => {
    const prevLength = blackList.length;
    const currentLength = blackList.push(token);
    if(currentLength > prevLength){
        return true;
    }
    return false;
}