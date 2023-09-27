import axios from 'axios';
import {openai} from '../config/openai.js';
import { AuthRequest } from '../middlewares/auth.middleware.js';
import {Response, response} from 'express';
import fs from 'fs';
import path from 'path';
import FormData from 'form-data';

const createCustomPrompt = (commonName:string, botanicalName: string) => {
    return `generate only in json format for a plant called "${commonName}", with scientific name "${botanicalName}
    " and fill, with real accurate data, the following:
    a brief description,
    an array of key facts containing only 6 key value pairs. the value is only made up of one word. the keys are: Seasonality, Edibility, Habitat, Toxicity, Use, convervation_status
    an array of recipes. each with a title, and indgredients. make it brief
    an array of top 5 health benefits,
    an array of top 5 common uses,
    an array of regions it grows in. a region is defined by a name. only a name`;
}


  export async function identifyPlantByImage(req: AuthRequest, res: Response) {
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
    
        return res.status(200).json({
            commonName: response.data.results[0].commonNames[0],
            botanicalName: response.data.results[0].species.scientificNameWithoutAuthor
        })
      } catch (error) {
        return res.status(response.statusCode).json({
            error: error
        })
      }
  }

export const getPlantData = async (req: AuthRequest, res: Response) => {
    const {commonName, botanicalName} = req.body;
    let response = null;

    try {
        response = await openai.completions.create({
            model: 'text-davinci-003',
            prompt: createCustomPrompt(commonName, botanicalName),
            max_tokens: 100,
            temperature: 0,
        });
    
        let res = response.choices[0].text.replace(/\\/g, '').replace(/\n/g, '');
        res = res.replace(/\\"/g, '"');
    } catch (error) {
        return res.status(500).json({
            error: error
        });
    }

    return res.status(200).json({
        data: res
    });
    
}



