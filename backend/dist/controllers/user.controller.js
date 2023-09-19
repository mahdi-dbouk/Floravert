import User from '../models/user.model.js';
import { decodeThenSendToS3 } from '../utils/image.handler.js';
import { validationResult } from 'express-validator';
import mongoose from 'mongoose';
export const addScanned = async (req, res) => {
    const _id = req.user._id;
    //validation errors
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({
            errors: errors.array()
        });
    }
    const { commonName, botanicalName, base64Image, keyFacts, description, recipes, regions } = req.body;
    const awsResponse = await decodeThenSendToS3(base64Image);
    try {
        const updatedUser = await User.findByIdAndUpdate(_id, {
            $push: {
                scannedPlants: {
                    commonName,
                    botanicalName,
                    description,
                    image: awsResponse.Location,
                    keyFacts: { ...keyFacts },
                    recipes: [...recipes],
                    regions: regions
                }
            }
        }, { new: true });
        if (updatedUser) {
            return res.status(200).json({
                message: "added successfully"
            });
        }
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
export const addPost = async (req, res) => {
    //validation errors
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({
            errors: errors.array()
        });
    }
    const _id = req.user._id;
    const { content } = req.body;
    const post = {
        content: content,
    };
    try {
        const updatedUser = await User.findByIdAndUpdate(_id, {
            $push: {
                posts: post
            }
        }, { new: true });
        console.log(updatedUser);
    }
    catch (error) {
        console.log(error);
    }
};
export const follow = async (req, res) => {
    const { userId } = req.body;
    const _id = req.user._id;
    try {
        const user = await User.findOne({ _id });
        if (user.followed.includes(userId)) {
            return res.status(400).json({
                message: "User is already followed"
            });
        }
        const updatedUser = await User.findOneAndUpdate({ _id }, { $push: { followed: userId } }, { new: true });
        const followedUser = await User.findOneAndUpdate({ _id: userId }, { $push: { followers: _id } }, { new: true });
        if (updatedUser && followedUser) {
            return res.status(200).json({
                message: "followed"
            });
        }
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
export const unfollow = async (req, res) => {
    const { userId } = req.body;
    const _id = req.user._id;
    console.log(_id, userId);
    try {
        const user = await User.findOne({ _id });
        if (!user.followed.includes(userId)) {
            return res.status(400).json({
                message: "User is already unfollowed"
            });
        }
        const updatedUser = await User.findOneAndUpdate({ _id: _id }, { $pullAll: { followed: [new mongoose.Types.ObjectId(userId)] } }, { new: true });
        const followedUser = await User.findOneAndUpdate({ _id: userId }, { $pullAll: { followers: [new mongoose.Types.ObjectId(_id)] } }, { new: true });
        return res.status(200).json({
            message: "unfollowed"
        });
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
export const becomeTrader = async (req, res) => {
    const _id = req.user._id;
    try {
        const updatedUser = await User.findOneAndUpdate({ _id }, {
            $set: { isTrader: true }
        }, { new: true });
        res.status(200).json({
            message: "Account converted successfully",
            user: updatedUser
        });
    }
    catch (error) {
        res.status(500).json({
            message: "failed to convert the account",
            error: error
        });
    }
};
//# sourceMappingURL=user.controller.js.map