import {Request, Response} from 'express';
import User from '../models/user.model.js';
import mongoose from 'mongoose';

export const getAllPosts = async (req: Request, res: Response) => {
    const users = await User.find({}, 'posts');
    try {
        const allPosts = users.flatMap(user => user.posts);
        return res.status(200).json({
            data: allPosts
        });
    } catch (error) {
        return res.status(500).json({
            error: error
        });
    }
}

export const addLike = async (req: Request, res: Response) => {
    const {postId, userId} = req.body;

    try {
        const user = await User.findOneAndUpdate(
            {_id: userId, 'posts._id': postId},
            {$inc: {'posts.$.likes': 1}}, 
            {new: true}
        );

        return res.status(200).json({
            message: "like added"
        });
        
    } catch (error) {
        return res.status(500).json({
            error: error
        });
        
    }
}