import {openai} from '../config/openai.js';
import { AuthRequest } from '../middlewares/auth.middleware.js';
import { ScanedRequest } from '../middlewares/api.middleware.js';
import {Response} from 'express';

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

export const getPlantData = async (req: ScanedRequest, res: Response) => {
    const {commonName, botanicalName} = req.plant;
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



