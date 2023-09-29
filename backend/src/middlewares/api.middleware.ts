import axios from "axios";
import { Response, NextFunction } from "express";
import { AuthRequest } from "./auth.middleware.js";
import { decodeThenSendToS3 } from "../utils/image.handler.js";

export interface ScanedRequest extends AuthRequest {
    plant?: {
        commonName: string,
        botanicalName: string,
    }
}


export async function identifyPlantByImage(req: ScanedRequest, res: Response, next: NextFunction) {
    const {base64Image} = req.body;

  try {
      const awsResponse = await decodeThenSendToS3(base64Image);
      const imageURL : string = awsResponse.Location;

      try {
          const response = await axios.get(`https://my-api.plantnet.org/v2/identify/all?images=${imageURL}&include-related-images=false&no-reject=false&lang=en&api-key=${process.env.PLANTNET_API_KEY}`);
          const commonName = response.data.results[0].species.commonNames[0];
          const botanicalName = response.data.results[0].species.scientificNameWithoutAuthor;
          console.log(commonName);
          console.log(botanicalName);
          const plant = {
                commonName: commonName,
                botanicalName: botanicalName
            };

            req.plant = plant;


      } catch (error) {
          console.log(error);
      }
      
        next();

    } catch (error) {
      return res.status(500).json({
          error: error
      })
    }
}