import { AuthRequest } from "../middlewares/auth.middleware.js";
import { Response } from "express";
import User from "../models/user.model.js";

export const getAllPlants = async (req: AuthRequest, res: Response) => {
    const users = await User.find();
    const allPlants = [];


    try {
        for (const user of users) {
          for (const plant of user.scannedPlants) {
                allPlants.push(plant);
          }
        }
        
        return res.status(200).json({
            data: allPlants
        });
    } catch (error) {
        return res.status(500).json({
            error: error
        });
    }

}