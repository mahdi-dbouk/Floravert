import User from '../models/user.model.js';
import 'dotenv/config';
import bcrypt from 'bcrypt';
import jsonwebtoken from 'jsonwebtoken';
import { validationResult } from 'express-validator';
import { decodeThenSendToS3 } from '../utils/image.handler.js';
const jwt = jsonwebtoken;
export const login = async (req, res) => {
    const { email, password } = req.body;
    //check if user exists
    const user = await User.findOne({ email });
    if (!user) {
        return res.status(404).json({
            success: false,
            message: "Incorrect Email/Password"
        });
    }
    //check if password matches
    const isCorrect = bcrypt.compare(password, user.hashedPassword);
    if (!isCorrect) {
        return res.status(404).json({
            success: false,
            message: "Incorrect Email/Password"
        });
    }
    const { hashedPassword: hashedPassword, _id, firstName, lastName, phone, picture_url, age, ...userInfo } = user.toJSON();
    const secret = process.env.JWT_SECRET_KEY;
    const token = jwt.sign({ _id, firstName, lastName, email }, secret);
    res.send({
        token,
        user: userInfo
    });
};
export const register = async (req, res) => {
    //check if all fields are correct
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({
            errors: errors.array()
        });
    }
    //extract fields from request body
    const { firstName, lastName, email, password, phone, age, base64Image } = req.body;
    //check if user exists
    const userExists = await User.findOne({ email });
    if (userExists) {
        return res.status(401).json({
            message: "user already exists"
        });
    }
    //if user does not exist
    const awsResponse = await decodeThenSendToS3(base64Image);
    try {
        const user = new User({
            firstName,
            lastName,
            email,
            hashedPassword: await bcrypt.hash(password, 10),
            age,
            phone,
            picture_url: awsResponse.Location,
            isTrader: false,
            posts: [],
            followrs: [],
            followed: [],
            scannedPlants: [],
            messages: [],
            contacts: []
        });
        const userData = await user.save();
        const { _id, picture_url } = userData;
        const secret = process.env.JWT_SECRET_KEY;
        const token = jwt.sign({ _id, firstName, lastName, email }, secret);
        return res.status(201).json({
            message: "created successfully",
            token: {
                type: 'Bearer',
                content: token
            },
            data: {
                firstName,
                lastName,
                email,
                phone,
                age,
                picture_url
            }
        });
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
//# sourceMappingURL=auth.controller.js.map