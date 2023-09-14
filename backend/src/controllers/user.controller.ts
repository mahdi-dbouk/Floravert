import {Response} from 'express';
import { AuthRequest } from '../middlewares/auth.middleware.js';
import User from '../models/user.model.js';
import { decodeThenSendToS3 } from '../utils/image.handler.js';
import {validationResult} from 'express-validator';

export const addScanned = async (req: AuthRequest, res:Response) => {
    const _id = req.user._id;

    //validation errors
    const errors = validationResult(req);
    if(!errors.isEmpty()){
        return res.status(422).json({
            errors: errors.array()
        });
    }
    

    const {
        commonName, 
        botanicalName, 
        base64Image,
        keyFacts,
        description,
        recipes,
        regions

    } = req.body;

    const awsResponse = await decodeThenSendToS3(base64Image);

    try {
        const updatedUser = await User.findByIdAndUpdate(_id, {
            $push: {
                scannedPlants: {
                    commonName,
                    botanicalName,
                    description,
                    image: awsResponse.Location,
                    keyFacts: {...keyFacts},
                    recipes:[...recipes],
                    regions: regions
                }
            }
        },
        {new: true}
        );

        if(updatedUser){
            return res.status(200).json({
                message: "added successfully"
            });
        }
    } catch (error) {
        return res.status(500).json({
            error: error
        });
    }
}