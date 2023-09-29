import axios from "axios";
import { Response, NextFunction } from "express";
import { AuthRequest } from "./auth.middleware.js";
import fs from 'fs';
import path from 'path';
import FormData from 'form-data';

export interface ScanedRequest extends AuthRequest {
    plant?: {
        commonName: string,
        botanicalName: string,
    }
}


export async function identifyPlantByImage(req: AuthRequest, res: Response, next: NextFunction) {
    const {base64Image} = req.body;
    let form = new FormData();

  try {
      let [format, base64ImageData] = base64Image.split(';base64,');
      const contentType = format.split(':')[1];
      format = format.split('/').pop();
      console.log(format);
      const filename = `image_${Date.now()}.${format}`;
      const imageBuffer: Buffer = Buffer.from(base64ImageData, 'base64');

      try {
          const tempImagePath = path.join('../assets/', filename);
          fs.writeFileSync(tempImagePath, imageBuffer);
          form.append('images', fs.createReadStream(tempImagePath));

      } catch (error) {
          console.log(error);
      }
  
      const response = await axios.post(`https://my-api.plantnet.org/v2/identify/all?include-related-images=false&no-reject=false&lang=en&api-key=${process.env.PLANTNET_API_KEY}`, form, {
          headers: form.getHeaders()
      });
  
        const commonName = response.data.results[0].commonNames[0];
        const botanicalName = response.data.results[0].species.scientificNameWithoutAuthor;

        const plant = {
            commonName,
            botanicalName
        };



        next();

    } catch (error) {
      return res.status(500).json({
          error: error
      })
    }
}