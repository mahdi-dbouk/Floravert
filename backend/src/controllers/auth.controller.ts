import {Request, Response} from 'express';
import User from '../models/user.model.js';
import 'dotenv/config';
import bcrypt from 'bcrypt';
import jsonwebtoken, { Secret } from 'jsonwebtoken';
const jwt : typeof jsonwebtoken = jsonwebtoken;

export const login = async (req: Request, res: Response) => {
    const {email, password} = req.body;

    //check if user exists
    const user = await User.findOne({email});
    if(!user){
        return res.status(404).json({
            success: false,
            message: "Incorrect Email/Password"
        });
    }

    //check if password matches
    const isCorrect = bcrypt.compare(password, user.password);
    if(!isCorrect){
        return res.status(404).json({
            success: false,
            message: "Incorrect Email/Password"
        });
    }

    const {password:hashedPassword, _id, firstName, lastName, phone, picture_url, age, ...userInfo } = user.toJSON();

    const secret : Secret = process.env.JWT_SECRET_KEY;
    const token = jwt.sign({_id, firstName, lastName, email}, secret);

    res.send({
        token,
        user: userInfo
    });
}
