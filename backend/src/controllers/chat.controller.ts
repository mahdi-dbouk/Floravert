import {Response} from 'express';
import { AuthRequest } from '../middlewares/auth.middleware.js';
import User from '../models/user.model.js';


export const createContact = async (req: AuthRequest, res: Response) => {
    const _id = req.user._id;
    const {userId} = req.body;

    try {
        //save contact to database
        const user = await User.findByIdAndUpdate(
            {_id},
            {$push: {
                contacts: { user: {_id: userId}}
            }},
            {new: true}
        );

        return res.status(201).json({
            message: "Contact Created",
            user
        });
        
    } catch (error) {
        return res.status(500).json({
            erro: error
        });
    }
}